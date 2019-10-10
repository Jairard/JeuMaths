extends Node

func get_first_component_in_parent(node : Node2D, resource : Resource, system : System) -> Component:
	if node == null or system == null:
		return null
		
	var Node_Id = node.get_instance_id()
	var comp : Component = system._getComponentOfEntity(Node_Id, resource)
	
	if comp != null:
		return comp
	return get_first_component_in_parent(node.get_parent(), resource, system)