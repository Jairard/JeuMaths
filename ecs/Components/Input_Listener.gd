extends Component

class_name InputListenerComponent

var left = false
var right = false
var is_jumping = false
var move = false

func get_move() -> bool:
	return move

func set_move(_bool) -> void:
	move = _bool
	
func get_left() -> bool:
	return left

func set_left(_bool) -> void:
	left = _bool

func get_right() -> bool:
	return right

func is_jumping() -> bool:
	return is_jumping
func set_right(_bool) -> void:
	right = _bool

func set_is_jumping(_bool) -> void:
	is_jumping = _bool
