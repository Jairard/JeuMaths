extends Node

func _ready():
	randomize()
	
func vector(x_min, x_max, y) -> Vector2:
	return Vector2(rand_range(x_min, x_max), y)
	
	
func velocity() -> Vector2:
	return Vector2(100,100)


func randi_to(numb : int) -> int:
	return randi() % numb





