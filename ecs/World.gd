extends Node

class_name ECS_World

var active_systems = {}
var components = {}
var is_processing = false

func _ready():
	var res = get_tree().connect("node_removed", self, "__on_node_removed")

func __on_node_removed(node : Node) -> void:
	if (is_processing == true):
		push_error("ECS.__on_node_removed: removing the node " + str(node) + " while processing !")

	# Delete all the associated components
	for componentType in components:
		remove_component(node, componentType, false)

func register_system(systemResource : Resource) -> bool:
	if (active_systems.has(systemResource)):
		print("ECS.register_system: system " + systemResource.resource_path + " is already registered")
		return false

	var system = __instanciate_system(systemResource)
	if (system == null):
		print("ECS.register_system: couldn't create system " + systemResource.resource_path)
		return false

	active_systems.append(system)
	return true

func unregister_system(systemResource : Resource) -> bool:
	if (!active_systems.has(systemResource)):
		print("ECS.unregister_system: system " + systemResource.resource_path + " is not registered")
		return false

	active_systems[systemResource].free()
	active_systems.erase(systemResource)
	return true

func __instanciate_system(systemResource : Resource):
	return systemResource.new()

func add_component(node : Node, componentResource : Resource) -> bool:
	if (node == null):
		print("ECS.add_component: node is null")
		return false

	if (!components.has(componentResource)):
		components[componentResource] = {}

	var id = node.get_instance_id()
	var typedComponents = components[componentResource]
	if (typedComponents.has(id)):
		print("ECS.add_component: node " + str(node) + " already has a component " + componentResource.resource_path)
		return false

	var component = __instanciate_component(id, componentResource)
	if (component == null):
		print("ECS.add_component: couldn't create component " + componentResource.resource_path)
		return false
	
	typedComponents[id] = component
	return true

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

	var root = __get_root_node()
	if (root == null):
		return

	for system in active_systems:
		__process_system(system, root, dt)

	is_processing = false

func __get_root_node() -> Node:
	return get_tree().get_current_scene()

func __process_system(system : System, node : Node, dt : float):
	if (node == null):
		return

	var id = node.get_instance_id()
	var components = __get_components_for_system(system, id)
	if (components != null):
		system._process_node(dt, components)

	for child in node.get_children():
		__process_system(system, child, dt)

# Gets all the components that the system needs
func __get_components_for_system(system : System, id : int):
	var components = {}
	for componentType in system._get_used_components():
		if (components.has(componentType)):
			print("ECS.__get_components_for_system: system " + system.resource_path + " uses several times the component of type " + componentType.resource_path)
			return null

		var component = __get_component(id, componentType)
		if (component == null):
			print("ECS.__get_components_for_system: object " + str(id) + " doesn't have a component of type " + componentType.resource_path)
			return null

		components[componentType] = component
		
	return components
