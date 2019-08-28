extends System

class_name PatrolSystem

func _get_used_components() -> Array:
	return [ComponentsLibrary.Movement, ComponentsLibrary.Position, ComponentsLibrary.Animation, ComponentsLibrary.Patrol]

func _process_node(dt : float, components : Dictionary) -> void:
	
#	var comp_mov = components[ComponentsLibrary.Movement] as MovementComponent
	var comp_pos = components[ComponentsLibrary.Position] as PositionComponent
	var comp_patrol = components[ComponentsLibrary.Patrol] as PatrolComponent
	var comp_anim = components[ComponentsLibrary.Animation] as AnimationComponent
	
	print (comp_patrol.right_move)
	
	if comp_patrol.right_move() == true :
#		comp_pos.set_position(comp_pos.get_position(Vector2(comp_patrol.x_min,425)))
		comp_anim.play(comp_anim.anim.right)
		
	if comp_patrol.right_move() == false :
		comp_anim.play(comp_anim.anim.left)
		
		
		