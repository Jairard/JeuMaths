extends System

class_name BounceSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Position, ComponentsLibrary.Nodegetid, ComponentsLibrary.Collision, ComponentsLibrary.Bounce, ComponentsLibrary.Velocity]

func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Collision]

func _process_node(dt : float, components : Dictionary) -> void:
	var pos_comp 	= 	components[ComponentsLibrary.Position]		 as  PositionComponent
	var bounce_comp	= 	components[ComponentsLibrary.Bounce] 	 	 as  BounceComponent
	var vel_comp	= 	components[ComponentsLibrary.Velocity] 	 	 as  VelocityComponent

	var current_velocity = vel_comp.get_velocity()
	if bounce_comp.is_bouncing() == true :
		var normal : Vector2 = bounce_comp.get_normal()
		if normal.x == -1 or normal.x == 1:
			current_velocity.x *= (-1)
		if normal.y == 1 or normal.y == -1:
			current_velocity.y *= (-1)
		vel_comp.set_velocity(current_velocity)
		bounce_comp.stop_bouncing()
	pos_comp.move_and_slide(current_velocity)




