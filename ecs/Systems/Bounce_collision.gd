extends System

class_name BounceSystem

var velocity : Vector2
const gravity : int= 1500

func _get_used_components() -> Array:
	return [ComponentsLibrary.Position, ComponentsLibrary.Nodegetid]

#func _get_system_dependencies() -> Array:
#	return [SystemsLibrary.Position]

func _process_node(dt : float, components : Dictionary) -> void:
	var pos_comp 	= 	components[ComponentsLibrary.Position]		 as  PositionComponent
	var ans_comp	= 	components[ComponentsLibrary.Nodegetid] 	 as  NodegetidComponent
	
	velocity.x = 0
	velocity.y = gravity * dt
	
	var answer_pos_comp = _getComponentOfEntity(ans_comp.get_target_id(), ComponentsLibrary.Position)
	answer_pos_comp.move_and_slide(velocity)
