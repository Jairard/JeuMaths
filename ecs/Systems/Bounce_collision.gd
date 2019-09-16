extends System

class_name BounceSystem

var velocity : Vector2
var pos : Vector2

func _get_used_components() -> Array:
	return [ComponentsLibrary.Position]

#func _get_system_dependencies() -> Array:
#	return [SystemsLibrary.Position]

func _process_node(dt : float, components : Dictionary) -> void:
	var pos_comp = components[ComponentsLibrary.Position] as PositionComponent
	
#	var _pos_comp = _getComponentOfEntity(pos_comp.get_target_id(), ComponentsLibrary.Position)
	velocity = Vector2(50,0)
#	print (_pos)	
	pos_comp.move_and_slide(velocity)