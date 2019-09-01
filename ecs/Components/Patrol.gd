extends Component

class_name PatrolComponent

var x_min_ref = 0
var x_min = 0
var x_max = 0

var patrol = true

func init(value_min : int, value_max : int) -> void : 
	x_min = value_min
	x_max = value_max
	x_min_ref = value_min
	
func get_pattern() -> bool :
	return patrol

func set_pattern(value : bool) -> void :
	patrol = value	

func get_position() -> Vector2:
	return get_node().get_position()

func set_position(pos : Vector2) -> void :
	get_node().set_position(pos)