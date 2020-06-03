extends Node

var active_systems : Dictionary = {}   # Dictionary(Resource -> System)
var system_scopes : Dictionary = {}    # Dictionary(SystemScope -> Array[Resource])
var ordered_systems :  Array = []      # Array[Resource]
var needs_systems_ordering = false
var components : Dictionary = {}       # Dictionary(Resource -> Dictionary(Id -> Component))
var active_entities : Dictionary = {}  # Dictionary(Id -> int) / Stores the active entites and the count of components attached to them
var entities_components_by_system : Dictionary = {} # Dictionary(Resource -> Dictionary(Id -> Array[component])
var is_processing : bool  = false
var ghosts : GhostsHandler = preload("res://ecs/Internal/GhostsHandler.gd").new()
var is_world_paused : bool = false
var log_profiling_infos : bool = false

enum SystemScope { Scene, Manual }

class SystemDurationSorter:
	static func sort(a : Array, b : Array) -> bool:
		return a[1] > b[1]

func _ready():
	system_scopes[SystemScope.Scene] = []
	system_scopes[SystemScope.Manual] = []
	get_tree().connect("node_removed", self, "__on_node_removed")
	get_tree().connect("node_added", self, "__on_node_added")
	DebugUtils.set_is_enabled(true)
	set_pause_mode(Node.PAUSE_MODE_PROCESS)

func _notification(what):
	if what == Node.NOTIFICATION_PAUSED:
		is_world_paused = true
	elif what == Node.NOTIFICATION_UNPAUSED:
		is_world_paused = false

func __on_node_removed(node : Node) -> void:
	if (is_processing == true):
		EcsUtils.log_and_push_error("ECS.__on_node_removed: removing the node " + str(node) + " while processing !")

	# Delete all the associated components
	for componentType in components:
		remove_component(node, componentType, false)
	active_entities.erase(node.get_instance_id())

func __on_node_added(node : Node) -> void:
	var isSceneChanging = (node == get_tree().get_current_scene())

	# If the scene changes, we unregister all the systems with the scope "Scene"
	if (isSceneChanging):
		var systems = system_scopes[SystemScope.Scene]
		while (!systems.empty()):
			unregister_system(systems.back())
		DebugUtils.clear()

func register_system(systemResource : Resource, scope = SystemScope.Scene) -> System:
	if (active_systems.has(systemResource)):
		EcsUtils.log_and_push_warning("ECS.register_system: system " + systemResource.resource_path + " is already registered")
		return null

	var system = __instanciate_system(systemResource)
	if (system == null):
		EcsUtils.log_and_push_error("ECS.register_system: couldn't create system " + systemResource.resource_path)
		return null

	if (not __check_system(system, systemResource.resource_path)):
		return null

	ordered_systems.push_back(systemResource)
	active_systems[systemResource] = system
	system_scopes[scope].push_back(systemResource)
	needs_systems_ordering = true

	var entities_and_components : Dictionary = {}
	for id in active_entities:
		var components = __get_components_for_system(system, id)
		if (components  != null):
			entities_and_components[id] = components
	entities_components_by_system[system] = entities_and_components

	return system

func __check_system(system : System, resPath : String) -> bool:
	# Check for doublons in mandatory components
	var mandatoryComps = system._get_mandatory_components()
	var mandatoryDoublons = ArrayUtils.get_doublon_indices(mandatoryComps)
	for i in mandatoryDoublons:
		EcsUtils.log_and_push_error("ECS.__check_system: " + resPath + ": component " + mandatoryComps[i].resource_path + " is listed several times in mandatory components")

	# Check for doublons in optional components
	var optionalComps = system._get_optional_components()
	var optionalDoublons = ArrayUtils.get_doublon_indices(optionalComps)
	for i in optionalDoublons:
		EcsUtils.log_and_push_error("ECS.__check_system: " + resPath + ": component " + optionalComps[i].resource_path + " is listed several times in optional components")

	# Check for components that are both in mandatory and optional components
	ArrayUtils.remove_doublons(mandatoryComps)
	ArrayUtils.remove_doublons(optionalComps)
	var comps = mandatoryComps + optionalComps
	var compDoublons = ArrayUtils.get_doublon_indices(comps)
	for i in compDoublons:
		EcsUtils.log_and_push_error("ECS.__check_system: " + resPath + ": component " + comps[i].resource_path + " is listed in mandatory and optional components")

	return (mandatoryDoublons.empty() and optionalDoublons.empty() and compDoublons.empty())

func unregister_system(systemResource : Resource) -> bool:
	if (!active_systems.has(systemResource)):
		EcsUtils.log_and_push_warning("ECS.unregister_system: system " + systemResource.resource_path + " is not registered")
		return false

	var system = active_systems[systemResource]
	entities_components_by_system.erase(system)
	system.free()
	active_systems.erase(systemResource)
	needs_systems_ordering = true

	for scope in system_scopes:
		if (ArrayUtils.remove_IFP(system_scopes[scope], systemResource)):
			break

	ArrayUtils.remove_IFP(ordered_systems, systemResource)
	return true

func __instanciate_system(systemResource : Resource) -> System:
	return systemResource.new() as System

func add_component(node : Node, componentResource : Resource, tag : String = "") -> Component:
	if (node == null):
		EcsUtils.log_and_push_error("ECS.add_component: node is null")
		return null

	if (!components.has(componentResource)):
		components[componentResource] = {}

	var id = node.get_instance_id()
	var typedComponents = components[componentResource]
	if (typedComponents.has(id)):
		EcsUtils.log_and_push_error("ECS.add_component: node " + str(node) + " already has a component " + componentResource.resource_path)
		return null

	# First check if there is a ghost to get the component from
	var component = ghosts.steal_ghost(id, componentResource, tag)
	# If it's nto the case, instanciate the component
	if (component == null):
		component = __instanciate_component(id, componentResource, tag)

	if (component == null):
		EcsUtils.log_and_push_error("ECS.add_component: couldn't create component " + componentResource.resource_path)
		return null

	typedComponents[id] = component

	if (!active_entities.has(id)):
		active_entities[id] = 0
	active_entities[id] += 1

	for system in entities_components_by_system:
		var entities_and_components = entities_components_by_system[system]
		entities_and_components[id] = __get_components_for_system(system, id)

	return component

func remove_component(node : Node, componentResource : Resource, mustExist : bool = true) -> bool:
	if (node == null):
		EcsUtils.log_and_push_error("ECS.remove_component: node is null")
		return false

	if (!components.has(componentResource)):
		EcsUtils.log_and_push_error("ECS.remove_component: unknown component " + componentResource.resource_path)
		return false

	var id = node.get_instance_id()
	var typedComponents = components[componentResource]
	if (!typedComponents.has(id)):
		if (mustExist):
			EcsUtils.log_and_push_warning("ECS.remove_component: node " + str(node) + " doesn't have a component " + componentResource.resource_path)
		return false

	var comp = typedComponents[id]

	# Ghost management and _on_destroyed call
	var is_ghost = ghosts.create_ghost_IFN(comp, componentResource)
	comp._on_destroyed()
	if (!is_ghost):
		comp.free()

	typedComponents.erase(id)

	if (!active_entities.has(id)):
		EcsUtils.log_and_push_error("ECS.remove_component: unknown entity " + str(node))
	elif (active_entities[id] <= 0):
		EcsUtils.log_and_push_error("ECS.remove_component: invalid entity component count: " + str(active_entities[id]))
		active_entities.erase(id)
	else:
		active_entities[id] -= 1
		if (active_entities[id] == 0):
			active_entities.erase(id)

	for system in entities_components_by_system:
		var entities_and_components = entities_components_by_system[system]
		entities_and_components[id] = __get_components_for_system(system, id)

	return true

func __get_component(id : int, componentResource : Resource) -> Component:
	if (!components.has(componentResource)):
		return null

	var typedComponents = components[componentResource]
	if (!typedComponents.has(id)):
		return null

	return typedComponents[id]

func __instanciate_component(id : int, componentResource : Resource, tag : String) -> Component:
	var component = componentResource.new() as Component
	component.__set_object_id(id)
	component.__set_tag(tag)
	return component

func _process(dt : float) -> void:
	is_processing = true
	var ti = OS.get_ticks_usec()

	if (__order_systems_IFN() == false):
		return
	var ordering_duration = OS.get_ticks_usec() - ti

	var duration_by_system : Array = []
	for systemType in ordered_systems:
		var start = OS.get_ticks_usec()
		var system : System = active_systems[systemType]
		var internal_duration = [0, 0]
		if (__can_process_system(system)):
			internal_duration = __process_system(system, dt)
		duration_by_system += [[systemType, OS.get_ticks_usec() - start] + internal_duration]

	is_processing = false

	if (log_profiling_infos):
		duration_by_system.sort_custom(SystemDurationSorter, "sort")
		var total_duration = OS.get_ticks_usec() - ti
		print("ECS world process time:")
		print("Ordering systems: " + __get_duration_string(ordering_duration))
		for type_and_duration in duration_by_system:
			var system_type = type_and_duration[0]
			var system_duration = type_and_duration[1]
			var duration_percent = (100.0 * system_duration) / total_duration
			var entity_count = len(entities_components_by_system[active_systems[system_type]])
			print("%s: %s (%.2f%%) - %d entities" % [system_type.resource_path, __get_duration_string(system_duration), duration_percent, entity_count])
			var misc_percent = (100.0 * type_and_duration[2]) / system_duration
			var process_percent = (100.0 * type_and_duration[3]) / system_duration
			print("\tinternal: %s (%.2f%%) / process: %s (%.2f%%)" %
				[__get_duration_string(type_and_duration[2]), misc_percent,
				 __get_duration_string(type_and_duration[3]), process_percent])
		print("Total: " + __get_duration_string(total_duration))

func __get_duration_string(usec : int) -> String:
	return "%.2fms" % [usec / 1000.0]

func __process_system(system : System, dt : float):
	var misc_duration = 0
	var process_duration = 0

	var entities_and_components = entities_components_by_system[system]
	for entityId in entities_and_components:
		var ti = OS.get_ticks_usec()
		var node = instance_from_id(entityId)
		if (node == null):
			misc_duration += OS.get_ticks_usec() - ti
			continue
		if (!node.is_inside_tree()):
			EcsUtils.log_and_push_warning("ECS.__process_system: entity " + str(entityId) + " is not inside tree")
			misc_duration += OS.get_ticks_usec() - ti
			continue

		var components = entities_and_components[entityId]
		var ti_process = OS.get_ticks_usec()
		misc_duration += ti_process - ti
		if (components != null):
			system._process_node(dt, components)
		process_duration +=  OS.get_ticks_usec()  - ti_process
	return [misc_duration, process_duration]

# Gets all the components that the system needs
func __get_components_for_system(system : System, id : int):
	if (system == null):
		return null

	var mandatoryComponents = __get_components_from_types(system._get_mandatory_components(), id, true)
	var optionalComponents = __get_components_from_types(system._get_optional_components(), id, false)

	if (mandatoryComponents == null or optionalComponents == null):
		return null

	# Merge mandatory and optional components
	var components = mandatoryComponents.duplicate()
	for comp in optionalComponents:
		components[comp] = optionalComponents[comp]
	return components

func __get_components_from_types(componentTypes : Array, id : int, mandatory : bool):
	var components = {}
	for componentType in componentTypes:
		var component = __get_component(id, componentType)
		if (component == null and mandatory):
			return null
		components[componentType] = component

	return components

# This is probably very suboptimal but it's not on a critical path and the system count should not get very high
func __order_systems_IFN() -> bool:
	if (!needs_systems_ordering):
		return true

	ordered_systems.clear()

	# For each system
	for systemResource in active_systems:
		# If it's already in the ordered list, skip it.
		# It means that it is a dependency of a previously visited system
		if (ArrayUtils.contains(ordered_systems, systemResource)):
			continue

		# Else we compute all the dependencies (recursively)
		var dependencies = __resolve_dependencies(systemResource)
		# This will get us the dependencies that are not ordered yet
		var missing_dependencies = ArrayUtils.get_diff(dependencies, ordered_systems)

		# For each one of them, we check that they are registered and add them to the ordered list
		for dep in missing_dependencies:
			if (not active_systems.has(dep)):
				continue
			ordered_systems.push_back(dep)
		# And finally we push the current system
		ordered_systems.push_back(systemResource)

	needs_systems_ordering = false
	return true

func __resolve_dependencies(systemResource : Resource) -> Array:
	if (not active_systems.has(systemResource)):
		return []

	var dependencies = active_systems[systemResource]._get_system_dependencies()
	for dep in dependencies:
		var indirectDependenciesependencies = __resolve_dependencies(dep)
		if (ArrayUtils.contains(indirectDependenciesependencies, dep)):
			EcsUtils.log_and_push_error("ECS.__resolve_dependencies: there is a cyclid dependency on " + systemResource.resource_path)
			return []
		# We put the current dependencies at the end (they come after their own dependencies)
		dependencies = indirectDependenciesependencies + dependencies

	return dependencies

func __can_process_system(system : System) -> bool:
	return (!is_world_paused || (system._get_pause_mode() != Node.PAUSE_MODE_STOP))

func set_system_pause_mode(systemResource : Resource, mode):
	if (active_systems.has(systemResource)):
		var system : System = active_systems[systemResource]
		var prev_mode : bool = system._get_pause_mode()
		system.set_pause_mode(mode)
		return prev_mode
	else:
		EcsUtils.log_and_push_error("ECS.set_system_pause_mode: the system " + systemResource.resource_path + " is not registered")
		return Node.PAUSE_MODE_PROCESS

func clear_ghosts() -> void:
	ghosts.clear()

func set_debug_mode(is_in_debug_mode : bool):
	log_profiling_infos = is_in_debug_mode
