extends Component

class_name DamageComponent

var dmg : int = 0

func init(current_damage : int) -> void:
	dmg = current_damage

func get_damage() -> int:
	return dmg
	
func set_damage(value : int) -> void:
	dmg = value

