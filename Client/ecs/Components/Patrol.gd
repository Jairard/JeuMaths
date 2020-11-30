extends Component

class_name PatrolComponent

var pos_start : Vector2 = Vector2(0,0)
var pos_end : Vector2 = Vector2(0,0)
var timer : float = 0
var ratio : float = 0

func init(_pos_start : Vector2, _pos_end  : Vector2, _timer : float) -> void :
	pos_start = _pos_start
	pos_end = _pos_end
	timer = _timer

func get_pos_start() -> Vector2:
	return pos_start

func get_pos_end() -> Vector2:
	return pos_end

func get_timer() -> float:
	return timer

func get_ratio() -> float:
	return ratio

func set_ratio(_ratio : float) -> void:
	ratio = _ratio
	if ratio >= 1:
		var pos = pos_start
		pos_start = pos_end
		pos_end = pos
		ratio = 0
