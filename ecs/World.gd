extends Node

var active_systems : Dictionary = {}
var system_scopes : Dictionary = {}
var ordered_systems :  Array = []
var needs_systems_ordering = false
var components : Dictionary = {}
var active_entities : Dictionary = {} # Stores the active entites and the count of components attached to them
var is_processing : bool  = false

enum SystemScope { Scene, Manual }

# TODO:
# - init syntactic sugar ?
# - optional component dependency
func _ready():
	system_scopes[SystemScope.Scene] = []
	system_scopes[SystemScope.Manual] = []
	get_tree().connect("node_removed", self, "__on_node_removed")
	get_tree().connect("node_added", self, "__on_node_added")

func __on_node_removed(node : Node) -> void:
	if (is_processing == true):
		push_error("ECS.__on_node_removed: removing the node " + str(node) + " while processing !")

	# Delete all the associated components
	for componentType in components:
		remove_component(node, componentType, false)

func __on_node_added(node : Node) -> void:
	var isSceneChanging = (node == get_tree().get_current_scene())

	# If the scene changes, we unregister all the systems with the scope "Scene"
	if (isSceneChanging):
		var systems = system_scopes[SystemScope.Scene]
		while (!systems.empty()):
			unregister_system(systems.back())

func register_system(systemResource : Resource, scope = SystemScope.Scene) -> bool:
	if (active_systems.has(systemResource)):
		print("ECS.register_system: system " + systemResource.resource_path + " is already registered")
		return false

	var system = __instanciate_system(systemResource)
	if (system == null):
		print("ECS.register_system: couldn't create system " + systemResource.resource_path)
		return false

	ordered_systems.push_back(systemResource)
	active_systems[systemResource] = system
	system_scopes[scope].push_back(systemResource)
	needs_systems_ordering = true

	return true

func unregister_system(systemResource : Resource) -> bool:
	if (!active_systems.has(systemResource)):
		print("ECS.unregister_system: system " + systemResource.resource_path + " is not registered")
		return false

	active_systems[systemResource].free()
	active_systems.erase(systemResource)
	needs_systems_ordering = true

	for scope in system_scopes:
		if (ArrayUtils.remove_IFP(system_scopes[scope], systemResource)):
			break

	ArrayUtils.remove_IFP(ordered_systems, systemResource)
	return true

func __instanciate_system(systemResource : Resource):
	return systemResource.new()

func add_component(node : Node, componentResource : Resource) -> Component:
	if (node == null):
		print("ECS.add_component: node is null")
		return null

	if (!components.has(componentResource)):
		components[componentResource] = {}

	var id = node.get_instance_id()
	var typedComponents = components[componentResource]
	if (typedComponents.has(id)):
		print("ECS.add_component: node " + str(node) + " already has a component " + componentResource.resource_path)
		return null

	var component = __instanciate_component(id, componentResource)
	if (component == null):
		print("ECS.add_component: couldn't create component " + componentResource.resource_path)
		return null
	
	typedComponents[id] = component

	if (!active_entities.has(id)):
		active_entities[id] = 0
	active_entities[id] += 1

	return component

func remove_component(node : Node, componentResource : Resource, mustExist : bool = true) -> bool:
	if (node == null):
		print("ECS.remove_component: node is null")
		return false

	if (!components.has(componentResource)):
		print("ECS.remove_component: unknown component " + componentResource.resource_path)
		return false

	var id = node.get_instance_id()
	var typedComponents = components[componentResource]
	if (!typedComponents.has(id)):
		if (mustExist):
			print("ECS.remove_component: node " + str(node) + " doesn't have a component " + componentResource.resource_path)
		return false

	typedComponents[id].free()
	typedComponents.erase(id)

	if (!active_entities.has(id)):
		print("ECS.remove_component: unknown entity " + str(node))
	elif (active_entities[id] <= 0):
		print("ECS.remove_component: invalid entity component count: " + str(active_entities[id]))
		active_entities.erase(id)
	else:
		active_entities[id] -= 1
		if (active_entities[id] == 0):
			active_entities.erase(id)

	return true

func __get_component(id : int, componentResource : Resource) -> Component:
	if (!components.has(componentResource)):
		return null

	var typedComponents = components[componentResource]
	if (!typedComponents.has(id)):
		return null

	return typedComponents[id]

func __instanciate_component(id : int, componentResource : Resource) -> Component:
	var component = componentResource.new()
	component.__set_object_id(id)
	return component

func _process(dt : float) -> void:
	is_processing = true

	if (__order_systems_IFN() == false):
		return

	for systemType in ordered_systems:
		__process_system(active_systems[systemType], dt)

	is_processing = false

func __process_system(system : System, dt : float):
	for entityId in active_entities:
		var node = instance_from_id(entityId)
		if (node == null):
			continue

		var components = __get_components_for_system(system, entityId)
		if (components != null):
			system._process_node(dt, components)

# Gets all the components that the system needs
func __get_components_for_system(system : System, id : int):
	var components = {}
	for componentType in system._get_used_components():
		if (components.has(componentType)):
			print("ECS.__get_components_for_system: system " + system.resource_path + " uses several times the component of type " + componentType.resource_path)
			return null

		var component = __get_component(id, componentType)
		if (component == null):
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
			print(systemResource.resource_path + " is already ordered")
			continue

		# Else we compute all the dependencies (recursively)
		var dependencies = __resolve_dependencies(systemResource)
		# This will get us the dependencies that are not ordered yet
		var missing_dependencies = ArrayUtils.get_diff(dependencies, ordered_systems)

		# For each one of them, we check that they are registered and add them to the ordered list
		for dep in missing_dependencies:
			if (not active_systems.has(dep)):
				push_error("ECS.__order_systems_IFN: system " + systemResource.resource_path + " has dependecy on system " + dep.resource_path + " but it's not registered")
				return false
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
			push_error("ECS.__resolve_dependencies: there is a cyclid dependency on " + systemResource.resource_path)
			return []
		# We put the current dependencies at the end (they come after their own dependencies)
		dependencies = indirectDependenciesependencies + dependencies

	return dependencies
