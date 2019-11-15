extends Node

func get_first_component_in_parent(node : Node2D, resource : Resource, system : System) -> Component:
	if node == null or system == null:
		return null
		
	var Node_Id = node.get_instance_id()
	var comp : Component = system._getComponentOfEntity(Node_Id, resource)
	
	if comp != null:
		return comp
	return get_first_component_in_parent(node.get_parent(), resource, system)

func get_absolute_position(pos_comp : PositionComponent) -> Vector2:
	if (pos_comp == null):
		return Vector2(0, 0)

	var node = pos_comp.get_node()
	if (node == null): # This case should not happen
		return Vector2(0, 0)

	var local_pos = pos_comp.get_position()
	var parent = node.get_parent()
	if (parent != null): # If we have a parent, then our global position can be computed
		return parent.to_global(local_pos)

	# Else we are at the root of the scene so our position is already global
	return local_pos

func log_and_push_warning(msg : String):
	print("WARNING: " + msg)
	push_error(msg)

func log_and_push_error(msg : String):
	print("ERROR: " + msg)
	push_error(msg)
