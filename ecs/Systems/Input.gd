extends System

class_name InputSystem
var counter = 0
var input_jump = 0
var is_jumping = 0
func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Movement, ComponentsLibrary.InputListener]

func _process_node(dt : float, components : Dictionary) -> void:
	var comp = components[ComponentsLibrary.Movement] as MovementComponent
	var input = components[ComponentsLibrary.InputListener] as InputListenerComponent

	# Move direction
	var move_direction = MoveUtils.dir.none
	if (input.get_move()):
		move_direction = MoveUtils.dir.mouse
	else:
		var keyboard_dir = MoveUtils.dir.none
		if Input.is_action_pressed("ui_right") != Input.is_action_pressed("ui_left") :
			if Input.is_action_pressed("ui_right"):# or Input.is_action_pressed("Arrow_right"):
				keyboard_dir = MoveUtils.dir.right
			elif Input.is_action_pressed("ui_left"):# or Input.is_action_pressed("Arrow_left"):
				keyboard_dir = MoveUtils.dir.left

		var touch_dir = input.get_move_dir()
		move_direction = __get_move_direction(keyboard_dir, touch_dir)
	comp.set_direction(move_direction)

	# Jump
	if comp.is_jumping() and comp.get_node().is_on_floor():
		comp.set_is_jumping(false)
	if Input.is_action_just_pressed("ui_accept"):
		input_jump += 1
		input.set_is_jumping(true)

	if input.is_jumping():
		# Consume the input
		is_jumping += 1
		input.set_is_jumping(false)
		# Trigger a real jump if possible
		if !comp.is_jumping():
#			counter += 1
			comp.set_start_jumping(true)
#	print(input_jump,"    ", is_jumping, "    ", counter)
	print(comp.get_node().is_on_floor())

func __get_move_direction(keyboard_dir, touch_dir):
	# Both inputs are the same, no conflict
	if (keyboard_dir == touch_dir):
		return keyboard_dir

	# keyboard_dir is unset, we use touch_dir
	if (keyboard_dir == MoveUtils.dir.none):
		return touch_dir
	# touch_dir is unset, we use keyboard_dir
	if (touch_dir == MoveUtils.dir.none):
		return keyboard_dir

	# Both keyboard_dir & touch_dir are set to different directions.
	# This should not happen but anyway we consider that the direction cancel each other.
	return MoveUtils.dir.none
