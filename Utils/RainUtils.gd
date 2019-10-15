extends Node

enum type_rain  {
	health_bonus = 0
	health_malus = 1
	coin = 2
	}
export (type_rain) var rain_type

func get_interval() -> Vector2:
	return Vector2(x_min, x_max)
	
func init_interval(_x_min : int, _x_max : int) -> void:
	x_min = _x_min
	x_max = _x_max

func spawn_rain(_array : Array) -> Object:
	array = _array
	for x in array:
		if array[x] != null:
			return get_node().add_child(x)
		else :
			return null
	
var interval = rain_comp.x_max - rain_comp.x_min
	var unique = []
	var i : int = 0 
	for x in range(0,interval,20):
		unique.append([])
		if randi() % 2 == 1 :
			unique[i].append(node)