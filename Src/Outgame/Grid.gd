extends Node2D

func _draw():
	var tileset : int = 1920
	var line_lengh : int = 1920
	var line_width : int = 20
	var start : Vector2 = Vector2(0,0)

	for i in range(0, tileset, 160):
		draw_line(start, Vector2((start.x + line_lengh), start.y),  Color.white)
		start.y += 160

	start = Vector2(0,0)

	for j in range(0, tileset, 160):
		draw_line(start,  Vector2(start.x, start.y + line_lengh),  Color.greenyellow)
		start.x += 160
