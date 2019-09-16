extends Node

var pos : Vector2

func get_position() -> Vector2:
	return pos
	
func set_position(_pos : Vector2) -> void:
	pos = _pos
	
func init(start : Vector2) -> void:
	randomize()
	pos = Vector2(rand_range(100,500), rand_range(200,400))
	
