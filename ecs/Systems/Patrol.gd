extends System

class_name PatrolSystem

var right_move = true
var left_move = false
var velocity = Vector2(150,0)

func _get_used_components() -> Array:
	return [ComponentsLibrary.Animation, ComponentsLibrary.Patrol]

func _process_node(dt : float, components : Dictionary) -> void:
	
	var comp_patrol  = 	components[ComponentsLibrary.Patrol] as PatrolComponent
	var comp_anim	 = 	components[ComponentsLibrary.Animation] as AnimationComponent
	
	var dp = velocity * dt
#	print (comp_anim.animation_names)
	
#	comp_patrol.set_pattern(true)

	if comp_patrol.patrol == true :
		comp_anim.play(comp_anim.anim.right)

		if right_move == true :
			
			if comp_patrol.x_min < comp_patrol.x_max :
				comp_patrol.x_min += 1 
				comp_patrol.set_position(comp_patrol.get_position() + dp)

			else :
				right_move = false
				left_move = true
	

		if left_move == true : 

			if comp_patrol.x_min > comp_patrol.x_min_ref :
				comp_patrol.x_min -= 1
				comp_patrol.set_position(comp_patrol.get_position() - dp)
				
			else : 
				right_move = true
				left_move = false
	


		
