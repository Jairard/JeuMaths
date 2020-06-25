extends Node2D

var input : Component = null

func set_controller(_input : Component, node : Node2D):
	input = _input

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.doubleclick:
		input.set_is_jumping(true)

func _on_right_button_up():
	input.set_move_dir(MoveUtils.dir.none)

func _on_right_button_down():
	input.set_move_dir(MoveUtils.dir.right)

func _on_left_button_up():
	input.set_move_dir(MoveUtils.dir.none)

func _on_left_button_down():
	input.set_move_dir(MoveUtils.dir.left)
