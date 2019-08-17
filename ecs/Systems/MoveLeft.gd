extends System

class_name MoveLeftSystem

#const velocity = Vector2(-60,0)

#func _get_used_components() -> Array:
#	return [ComponentsLibrary.Position]
#
#func _process_node(dt : float, components : Dictionary) -> void:
#	var dp = dt * velocity
#	var comp = components[ComponentsLibrary.Position] as PositionComponent
#	comp.set_position(comp.get_position() + dp)
#
#