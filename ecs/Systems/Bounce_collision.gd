extends System

class_name BounceSystem

var velocity : Vector2 = Vector2(50,50)

func _get_used_components() -> Array:
	return [ComponentsLibrary.Position, ComponentsLibrary.Nodegetid, ComponentsLibrary.Collision, ComponentsLibrary.Bounce]

func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Collision]

func _process_node(dt : float, components : Dictionary) -> void:
	var pos_comp 	= 	components[ComponentsLibrary.Position]		 as  PositionComponent
	var ans_comp	= 	components[ComponentsLibrary.Nodegetid] 	 as  NodegetidComponent
	var col_comp	= 	components[ComponentsLibrary.Collision] 	 as  CollisionComponent
	var bounce_comp	= 	components[ComponentsLibrary.Bounce] 	 	 as  BounceComponent

	if bounce_comp.is_bouncing() == true :
#		velocity = velocity.bounce(pos_comp.move_and_slide(RandomUtils.velocity()))
		pass
	pos_comp.move_and_slide(velocity)

	
	
	
	
	