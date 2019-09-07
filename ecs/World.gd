extends Node

var active_systems : Dictionary = {}
var system_scopes : Dictionary = {}
var components : Dictionary = {}
var active_entities : Dictionary = {} # Stores the active entites and the count of components attached to them
var is_processing : bool  = false

enum SystemScope { Scene, Manual }

# TODO:
# - init syntactic sugar ?
# - system-to-system dependency
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

	active_systems[systemResource] = system
	system_scopes[scope].push_back(systemResource)
	return true

func unregister_system(systemResource : Resource) -> bool:
	if (!active_systems.has(systemResource)):
		print("ECS.unregister_system: system " + systemResource.resource_path + " is not registered")
		return false

	active_systems[systemResource].free()
	active_systems.erase(systemResource)

	for scope in system_scopes:
		var idx = system_scopes[scope].find(systemResource)
		if (idx != -1):
			system_scopes[scope].remove(idx)
			break

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

	for systemType in active_systems:
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
