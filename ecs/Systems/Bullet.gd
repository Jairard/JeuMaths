extends System

class_name bulletSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Position, ComponentsLibrary.Bullet]

func _process_node(dt : float, components : Dictionary) -> void:
	var pos_comp = components[ComponentsLibrary.Position] as PositionComponent
	var vect = pos_comp.get_position()
	var bullet_pos  =  components[ComponentsLibrary.Bullet] as BulletComponent

	if pos_comp.get_position().x >= bullet_pos.get_position().x:
		vect.x -= 400 * dt
		pos_comp.set_position(vect)
	
	else:
		pos_comp.get_node().queue_free()



