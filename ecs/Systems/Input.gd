extends System

class_name InputSystem

func _get_used_components() -> Array:
	return [ComponentsLibrary.Movement]

func _process_node(dt : float, components : Dictionary) -> void:
	var comp = components[ComponentsLibrary.Movement] as MovementComponent

	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left") :
		comp.set_direction(comp.dir.none)
	elif Input.is_action_pressed("ui_right") :
		comp.set_direction(comp.dir.right)
	elif Input.is_action_pressed("ui_left") :
		comp.set_direction(comp.dir.left)


	else : 
		comp.set_direction(comp.dir.none)

	if Input.is_action_just_pressed("ui_accept"):
		comp.set_is_jumping(true)
