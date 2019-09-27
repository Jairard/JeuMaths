extends System

class_name BounceSystem

var current_velocity	: Vector2 #= Vector2(100,100)
var new_velocity 		: Vector2 = RandomUtils.velocity()

func _get_used_components() -> Array:
	return [ComponentsLibrary.Position, ComponentsLibrary.Nodegetid, ComponentsLibrary.Collision, ComponentsLibrary.Bounce, ComponentsLibrary.Velocity]

func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Collision]

func _process_node(dt : float, components : Dictionary) -> void:
	var pos_comp 	= 	components[ComponentsLibrary.Position]		 as  PositionComponent
	var ans_comp	= 	components[ComponentsLibrary.Nodegetid] 	 as  NodegetidComponent
	var col_comp	= 	components[ComponentsLibrary.Collision] 	 as  CollisionComponent
	var bounce_comp	= 	components[ComponentsLibrary.Bounce] 	 	 as  BounceComponent
	var vel_comp	= 	components[ComponentsLibrary.Velocity] 	 	 as  VelocityComponent

	if bounce_comp.is_bouncing() == true :
#		velocity = RandomUtils.velocity()
#		velocity = RandomUtils.vector(-100, 100, -100, 100)

		current_velocity = vel_comp.get_velocity()
		new_velocity = MoveUtils.vector_orthogonal(current_velocity)
		vel_comp.set_velocity(new_velocity)
		bounce_comp.set_is_bouncing(false)
		
	pos_comp.move_and_slide(new_velocity)

	
	
	
	
	