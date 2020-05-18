extends Node2D

var input : Component = null

func set_controller(_input : Component, node : Node2D):
	input = _input

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.doubleclick:
		input.set_jump(true)

func _on_right_button_up():
	input.set_right(false)
	input.set_left(false)

func _on_right_button_down():
	input.set_right(true)
	input.set_left(false)

func _on_left_button_up():
	input.set_right(false)
	input.set_left(false)

func _on_left_button_down():
	input.set_right(false)
	input.set_left(true)
