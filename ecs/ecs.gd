extends Node

# Improve: inject this ?
enum System { Damage, Spell }
enum Component { Life, Experience }

var root = null
var active_systems = {}
var components = {}

func _ready():
	for componentType in Component:
		components[componentType] = {}

func set_root(node):
	root = node

func register_system(type):
	if (active_systems.has(type)):
		print("ECS.register_system: system " + str(type) + " is already registered")
		return

	var system = __instanciate_system(type)
	if (system == null):
		print("ECS.register_system: couldn't create system " + str(type))
		return

	active_systems.append(system)

func unregister_system(type):
	if (!active_systems.has(type)):
		print("ECS.unregister_system: system " + str(type) + " is not registered")
		return

	active_systems.erase(type)

func __instanciate_system(type):
	return null # TODO

func add_component(node, type):
	if (node == null):
		print("ECS.add_component: node is null")
		return

	if (!components.has(type)):
		print("ECS.add_component: unknown component " + str(type))
		return

	var id = node.get_instance_id()
	var typedComponents = components[type]
	if (typedComponents.has(id)):
		print("ECS.add_component: node " + str(node) + " already has a component of type " + str(type))
		return

	var component = __instanciate_component(type)
	if (component == null):
		print("ECS.add_component: couldn't create component " + str(type))
		return
	
	typedComponents[id] = component

func remove_component(node, type):
	if (node != null):
		print("ECS.remove_component: node is null")
		return

	if (!components.has(type)):
		print("ECS.remove_component: unknown component " + str(type))
		return

	var id = node.get_instance_id()
	var typedComponents = components[type]
	if (!typedComponents.has(id)):
		print("ECS.remove_component: node " + str(node) + " doesn't have a component of type " + str(type))
		return

	typedComponents.erase(id)

func __get_component(id, type):
	if (!components.has(type)):
		return null

	var typedComponents = components[type]
	if (!typedComponents.has(id)):
		return null

	return typedComponents[id]

func __instanciate_component(type):
	return null # TODO

func _process(dt):
	if (root == null):
		return

	for system in active_systems:
		__process_system(system, root, dt)

func __process_system(system, node, dt):
	if (node == null):
		return

	var id = node.get_instance_id()
	var components = __get_components_for_system(system, id)
	if (components != null):
		system.process_node(dt, id, components)

	for child in node.get_children():
		__process_system(system, child, dt)

# Gets all the components that the system needs
func __get_components_for_system(system, id):
	var components = {}
	for componentType in system.get_used_components():
		if (components.has(componentType)):
			print("ECS.__get_components_for_system: system " + system + " uses several times the component of type " + str(componentType))
			return null

		var component = __get_component(id, componentType)
		if (component == null):
			print("ECS.__get_components_for_system: object " + str(id) + " doesn't have a component of type " + str(componentType))
			return null

		components[componentType] = component
		
	return components
