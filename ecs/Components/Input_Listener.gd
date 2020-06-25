extends Component

class_name InputListenerComponent

var dir = MoveUtils.dir.none
var is_jumping = false
var move = false

func get_move() -> bool:
	return move

func set_move(_bool) -> void:
	move = _bool

func set_move_dir(_dir) -> void:
	dir = _dir

func get_move_dir():
	return dir

func is_jumping() -> bool:
	return is_jumping

func set_is_jumping(_bool) -> void:
	is_jumping = _bool
