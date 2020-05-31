tool
extends Node2D

export var line_H_lengh : int = 1920	setget set_line_H_lengh
export var line_V_lengh : int = 1920	setget set_line_V_lengh
export var line_width : int = 20	setget set_line_width
export var start : Vector2 = Vector2(0,0)	setget set_start
export var color_H : Color = Color.white	setget set_color_H
export var color_V : Color = Color.greenyellow	setget set_color_V
const origin : Vector2 = Vector2(0,0)

func _init() -> void:
	update()

func set_line_H_lengh(value : int) -> void:
	line_H_lengh = value
	update()

func set_line_V_lengh(value : int) -> void:
	line_V_lengh = value
	update()

func set_line_width(value : int) -> void:
	line_width = value
	update()

func set_start(pos : Vector2) -> void:
	start = pos
	update()

func set_color_H(value : Color) -> void:
	color_H = value
	update()

func set_color_V(value : Color) -> void:
	color_V = value
	update()

func _draw():
	for i in range(0, line_H_lengh, 160):
		draw_line(start, Vector2((start.x + line_V_lengh), start.y),  color_H, line_width)
		start.y += 160

	start = origin

	for j in range(0, line_V_lengh, 160):
		draw_line(start,  Vector2(start.x, start.y + line_V_lengh),  color_V,  line_width)
		start.x += 160

	start = origin

