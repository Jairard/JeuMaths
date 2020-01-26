extends Component

class_name CharacterstatsComponent

var health 	: int = 0
var damage 	: int = 0

func init_stats(dict : Dictionary) -> void:
	health 	= dict["health"]
	damage 	= dict["damage"]