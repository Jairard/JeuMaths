tool
extends Node2D

export var line_H_lengh : int = 1920	setget set_line_H_lengh
export var line_V_lengh : int = 1920	setget set_line_V_lengh
export var line_spacing : int = 0	setget set_line_H_spacing
export var arrow_i_lengh : int = 1	setget set_axis_x_lengh
export var arrow_j_lengh : int = 1	setget set_axis_y_lengh
export var line_H_count : int = 0	setget set_line_H_count
export var line_V_count : int = 0	setget set_line_V_count
export var line_width : int = 1	setget set_line_width
export var start : Vector2 = Vector2(0,0)	setget set_start
export var color_H : Color = Color.white	setget set_color_H
export var color_V : Color = Color.greenyellow	setget set_color_V
var axis_position : Vector2= Vector2(0,0)
var axis_x : int = 0
var axis_y : int = 0
const origin : Vector2 = Vector2(0,0)
var scale_axis_x : float = 160
var scale_axis_y : float = 160

var color_h_axis : Color = color_H
var color_v_axis : Color = color_V

export var intersection_coordonates : bool = false setget set_intersection
var line_intersection : Array = []
var intersect_x : Array = []
var intersect_y : Array = []
var shape : CollisionShape2D = null
var circle : CircleShape2D = null
var shape_array : Array = []

func _init() -> void:
	update()

func set_intersection(value : bool) -> void:
	intersection_coordonates = value
	update()

func set_axis_x_lengh(value : int) -> void:
	arrow_i_lengh = value
	update()

func set_axis_y_lengh(value : int) -> void:
	arrow_j_lengh = value
	update()

func set_line_H_count(value : int) -> void:
	if value > 11:
		value = 11
	line_H_count = value
	set_intersection(false)
	update()

func set_line_V_count(value : int) -> void:
	if value > 11:
		value = 11
	line_V_count = value
	set_intersection(false)
	update()

func set_line_H_lengh(value : int) -> void:
	line_H_lengh = value
	update()

func set_line_V_lengh(value : int) -> void:
	line_V_lengh = value
	update()

func set_line_H_spacing(value : int) -> void:
	line_spacing = value
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
	intersect_x = []
	intersect_y = []
	line_intersection = []
	for i in range(0, line_H_count):#, line_V_spacing):
		if line_H_count %2 == 0 and i == line_H_count / 2:
			color_h_axis = Color.black
			axis_y = i
		elif line_H_count %2 == 1 and i == (line_H_count / 2):
			color_h_axis = Color.black
			axis_y = i
		else:
			color_h_axis = color_H

		intersect_x.append(i * line_spacing)

		draw_line(start, Vector2((start.x + line_H_lengh), start.y),  color_h_axis, line_width)
		start.y += line_spacing

	start = origin

	for j in range(0, line_V_count):#, line_H_spacing):
		if line_V_count %2 == 0 and j == line_V_count / 2:
			color_v_axis = Color.black
			axis_x = j
		elif line_V_count %2 == 1 and j == (line_V_count / 2):
			color_v_axis = Color.black
			axis_x = j
		else:
			color_v_axis = color_V

		intersect_y.append(j * line_spacing)

		draw_line(start,  Vector2(start.x, start.y + line_V_lengh),  color_v_axis,  line_width)
		start.x += line_spacing
	if intersection_coordonates:
		shape_array = []
		for k in len(intersect_x) :
			for l in len(intersect_y):
				line_intersection.append(Vector2(intersect_x[k], intersect_y[l]))
				shape = CollisionShape2D.new()
				shape_array.append(shape)
				add_child(shape)
				circle = CircleShape2D.new()
				shape.shape = circle
#				shape.modulate = Color(0,0,0,0)
				shape.set_position(Vector2(intersect_y[l], intersect_x[k]))
#		print(len(shape_array))

	else:
#		print(len(shape_array))
		for m in len(shape_array) :
#			shape_array.erase(m)
			shape_array[m].queue_free()
		shape_array = []
#		print(len(shape_array))


	start = origin
	axis_position = Vector2(axis_x * line_spacing, axis_y * line_spacing)
	origin_x(axis_position)
	origin_y(axis_position)
#	wall_creation(line_H_count, line_V_count, line_spacing)

func origin_x(pos : Vector2) -> void:
	var sprite_size = $arrow_x.texture.get_size()
	scale_axis_x = arrow_i_lengh * line_spacing / sprite_size.x
	$arrow_x.set_scale(Vector2(scale_axis_x , 0.4 * scale_axis_x))
	var sprite_scale_size = sprite_size * scale_axis_x
	$arrow_x.set_position(pos + Vector2(sprite_scale_size.x/2, 0))

	update()

func origin_y(pos : Vector2) -> void:
	var sprite_size = $arrow_y.texture.get_size()
	scale_axis_y = arrow_j_lengh * line_spacing / sprite_size.x
	$arrow_y.set_scale(Vector2(scale_axis_y , 0.4 * scale_axis_y))
	var sprite_scale_size = sprite_size * scale_axis_y
	$arrow_y.set_position(pos + Vector2(0, -sprite_scale_size.x/2))
	update()

func wall_creation(line_H_count : int, line_V_count: int, line_spacing: int):
	var wall_up : CollisionShape2D = CollisionShape2D.new()
	var wall_right : CollisionShape2D = CollisionShape2D.new()
	var wall_down : CollisionShape2D = CollisionShape2D.new()
	var wall_left : CollisionShape2D = CollisionShape2D.new()
	var rect : RectangleShape2D = RectangleShape2D.new()

	wall_up.shape = rect
	add_child(wall_up)
	wall_up.set_position(Vector2(0,0))
	wall_up.set_rotation_degrees(-90)
	wall_up.set_modulate(Color.red)

	wall_right.shape = rect
	add_child(wall_right)
	wall_right.set_position(Vector2(line_V_count * line_spacing, 0))
	wall_right.set_modulate(Color.red)

	wall_down.shape = rect
	add_child(wall_down)
	wall_down.set_position(Vector2(0, line_H_count * line_spacing))
	wall_down.set_rotation_degrees(-90)
	wall_down.set_modulate(Color.red)

	wall_left.shape = rect
	add_child(wall_left)
	wall_left.set_position(Vector2(-20,0))
	wall_left.set_modulate(Color.red)
