extends System

class_name MoveSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Position, ComponentsLibrary.Movement, ComponentsLibrary.Gravity, ComponentsLibrary.Velocity]

func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Input]

func _process_node(dt : float, components : Dictionary) -> void:
	var move_comp = components[ComponentsLibrary.Movement] as MovementComponent
	var pos_comp = components[ComponentsLibrary.Position] as PositionComponent
	var gravity_comp = components[ComponentsLibrary.Gravity] as GravityComponent
	var velocity_comp = components[ComponentsLibrary.Velocity] as VelocityComponent
	var velocity = velocity_comp.get_velocity()

	velocity.y += gravity_comp.get_gravity()
	if move_comp.get_direction() == MoveUtils.dir.right :
		velocity.x = move_comp.get_lateral_velocity()

	elif move_comp.get_direction() == MoveUtils.dir.left :
		velocity.x = -move_comp.get_lateral_velocity()

	elif move_comp.get_direction() == MoveUtils.dir.mouse :
		velocity = pos_comp.get_position().direction_to(move_comp.target) * move_comp.get_lateral_velocity()
		if pos_comp.get_position().distance_to(move_comp.target) < 5:
			velocity = Vector2(0,0)

	else :
		velocity.x = 0

	if move_comp.is_jumping() == true and move_comp.get_node().is_on_floor():
		velocity.y = -move_comp.get_jump_impulse()
		move_comp.set_is_jumping(false)
	velocity_comp.set_velocity(velocity)
	MoveUtils.move_and_slide(pos_comp, velocity_comp, dt)
