extends Node

var pos : Vector2
	
func init(x_min, x_max, y_min, y_max) -> void:
	randomize()
	pos = Vector2(rand_range(x_min, x_max), rand_range(y_min, y_max))
	print (pos)
