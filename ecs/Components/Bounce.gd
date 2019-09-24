extends Component

class_name BounceComponent

var bounce : bool = false

func is_bouncing() -> bool :
	return bounce
	
func set_is_bouncing(value : bool) -> void :
	bounce = value
	print (bounce)