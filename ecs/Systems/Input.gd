extends System

class_name InputSystem

func _get_used_components() -> Array:
	return [ComponentsLibrary.Movement]

func _process_node(dt : float, components : Dictionary) -> void:
	var comp = components[ComponentsLibrary.Movement] as MovementComponent
	if Input.is_action_just_pressed("ui_right") :
		comp.set_is_moving(true)
	elif Input.is_action_just_released("ui_right") : 
		comp.set_is_moving(false)

