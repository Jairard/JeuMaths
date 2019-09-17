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
	
	var answer_pos_comp = _getComponentOfEntity(ans_comp.get_target_id(), ComponentsLibrary.Position)
	var answer_pos = answer_pos_comp.get_position()
	
	velocity.x = 0
	velocity.y = gravity * dt
	 
	answer_pos.x = velocity.x 
	answer_pos.y = velocity.y 
	
	pos_comp.move_and_slide(answer_pos)
	
#	var target_pos_comp = _getComponentOfEntity(misl_comp.get_target_id(), ComponentsLibrary.Position)
#	if target_pos_comp != null :
#		var target_pos = target_pos_comp.get_position() # Target Position
#		var shooter_pos = pos_comp.get_position()       # Shooter position