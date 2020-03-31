extends Component

class_name DamageComponent

var damage : int = 0
var critic : float = 0
var timer : int = 0
var _bool = true

func init(current_damage : int, _timer : int) -> void:
	if (!was_ghost()):
		damage = current_damage
		timer = _timer

func get_damage() -> int:
	return damage

func set_damage(value : int) -> void:
	damage = value
