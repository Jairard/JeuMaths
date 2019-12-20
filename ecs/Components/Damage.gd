extends Component

class_name DamageComponent

var damage : int = 0

func init(current_damage : int) -> void:
	damage = current_damage

func get_damage() -> int:
	return damage
	
func set_damage(value : int) -> void:
	damage = value

