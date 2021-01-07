extends Component

class_name DamageComponent

var damage : float = 0
var critic : float = 0
var timer : int = 0

func init(current_damage : int, _timer : int) -> void:
	if (!was_ghost()):
		damage = current_damage
		timer = _timer

func get_damage() -> float:
	return damage

func set_damage(value : float) -> void:
	damage = value
