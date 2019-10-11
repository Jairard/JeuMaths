extends Component

class_name BounceComponent

var bounce : bool = false
var normal : Vector2 = Vector2(0,0)

func is_bouncing() -> bool :
	return bounce			
	
func get_normal() -> Vector2:
	return normal

func set_is_bouncing(value : bool, _normal : Vector2) -> void :			
	bounce = value
	normal = _normal