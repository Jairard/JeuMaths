extends Node2D

var light : Node2D = null
var rotation_value : float = 0
var pos :  float = 0
var angle = false
#var rotation_active = true

func get_light_value() -> TextureProgress:
	return $CanvasLayer/TextureProgress	as TextureProgress

func set_light_value(value : float) -> void:
	rotation_value = value

func _ready():
	light = get_parent()

func _process(delta):
#	get_light_value().value = rotation_value
	set_process_input(true)
	var mouse_pos : Vector2 = get_viewport().get_mouse_position()
	print(mouse_pos)
#	light_value()

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
#		if rotation_active:
		var mouse_pos : Vector2 = get_viewport().get_mouse_position()
		pos = mouse_pos.y
		if pos >= 407:
			pos = 407
		elif pos <= 124:
			pos = 124
		$CanvasLayer/StaticBody2D.set_position(Vector2(27, pos))
		light_value()
#		rotation_active = false


func light_value():
	if pos >= 407:
		$CanvasLayer/TextureProgress.value = 0
	elif pos <= 124:
		$CanvasLayer/TextureProgress.value = 100
	else:
		$CanvasLayer/TextureProgress.value = -0.35*pos + 144
		angle = true
		light_angle()

func light_angle():
	if angle:
		if pos >= 300:
			get_parent().set_rotation(45)
		elif pos <= 230:
			get_parent().set_rotation(-45)
		else:
			get_parent().set_rotation(0)
	angle = false

#	print("area")
#	rotation_active = true
