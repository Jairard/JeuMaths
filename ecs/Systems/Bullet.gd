extends System

class_name bulletSystem

func _get_used_components() -> Array:
	return [ComponentsLibrary.Movement]

func _process_node(dt : float, components : Dictionary) -> void:
	var move_comp = components[ComponentsLibrary.Movement] as MovementComponent

	if move_comp.line >= 0 :
		move_comp.velocity.x -= 200 * dt
		
	else : 
		move_comp.get_node().queue_free()
	
