extends System

class_name bulletSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Position, ComponentsLibrary.Bullet, ComponentsLibrary.Velocity]

func _process_node(dt : float, components : Dictionary) -> void:
	var pos_comp = components[ComponentsLibrary.Position] as PositionComponent
	var vect = pos_comp.get_position()
	var bullet_pos  =  components[ComponentsLibrary.Bullet] as BulletComponent
	var velocity_comp = components[ComponentsLibrary.Velocity] as VelocityComponent
	var velocity = velocity_comp.get_velocity()

	if pos_comp.get_position().x >= bullet_pos.get_position().x:
#		vect.x -= 400 * dt
#		pos_comp.set_position(vect)
		velocity.x = -400 

	else:
		pos_comp.get_node().queue_free()
	velocity_comp.set_velocity(velocity)
	MoveUtils.move_and_slide(pos_comp, velocity_comp, dt)


