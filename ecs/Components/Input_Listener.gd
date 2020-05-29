extends Component

class_name InputListenerComponent

var left = false
var right = false
var jump = false
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

func set_right(_bool) -> void:
	right = _bool

func get_jump() -> bool:
	return jump

func set_jump(_bool) -> void:
	jump = _bool
