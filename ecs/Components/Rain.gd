extends Component

class_name RainComponent

var x_min	: int 		= 0
var x_max 	: int 		= 0
var array 	: Array 	= []
var node 	: Node2D

enum type_rain  {
	health_bonus = 0
	health_malus = 1
	coin = 2
	}
export (type_rain) var rain_type

func get_interval() -> int:
	return x_min 
	return x_max
	
func init_interval(_x_min : int, _x_max : int, _node : Node2D) -> void:
	x_min = _x_min
	x_max = _x_max
	node = _node
	
func node() -> Node2D:
	return node

func spawn_rain(_array : Array) -> Object:
	array = _array
	for x in array:
		if array[x] != null:
			return node.add_child(x)
		else :
			return null
	
		
	
	
	
	