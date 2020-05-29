extends System

class_name InputSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Movement, ComponentsLibrary.InputListener]

func _process_node(dt : float, components : Dictionary) -> void:
	var comp = components[ComponentsLibrary.Movement] as MovementComponent
	var input = components[ComponentsLibrary.InputListener] as InputListenerComponent
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left") :
		comp.set_direction(comp.dir.none)
	elif Input.is_action_pressed("ui_right"):# or Input.is_action_pressed("Arrow_right"):
		comp.set_direction(comp.dir.right)
	elif Input.is_action_pressed("ui_left"):# or Input.is_action_pressed("Arrow_left"):
		comp.set_direction(comp.dir.left)
	else :
		comp.set_direction(comp.dir.none)

	if Input.is_action_just_pressed("ui_accept"):
		comp.set_is_jumping(true)

	if input.get_left():
		comp.set_direction(comp.dir.left)
	if input.get_right():
		comp.set_direction(comp.dir.right)
	if input.get_jump():
		print("jump")
		comp.set_is_jumping(true)
		input.set_jump(false)
	
	if input.get_move():
		comp.set_direction(comp.dir.mouse)
#		input.set_move(false)
