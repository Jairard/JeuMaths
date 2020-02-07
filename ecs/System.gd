extends Object

class_name System

func _get_mandatory_components() -> Array:
	return []

func _get_optional_components() -> Array:
	return []

func _get_used_components() -> Array:
	return _get_mandatory_components() + _get_optional_components()

func _get_system_dependencies() -> Array:
	return []

func _process_node(dt : float, components : Dictionary) -> void:
	pass

func _getComponentOfNode(node : Node, component : Resource) -> Component:
	if (node == null):
		return null
	return _getComponentOfEntity(node.get_instance_id(), component)

func _getComponentOfEntity(id : int, component : Resource) -> Component:
	var usedComponents = _get_used_components()
	if (!usedComponents.has(component)):
		push_error("System._getComponentOfEntity: requiring component " + component.resource_path + " through system "
				   + self.resource_path + " but it was neither registered in _get_mandatory_components not in _get_optional_components"
				   + " (id: " + str(id) + ")")
		return null
	return ECS.__get_component(id, component)
