extends Component

class_name HealthComponent

var health = 0
var health_max = 0

func init(current_health : int, max_health : int) -> void :
	if (!was_ghost()):
		health = current_health
		health_max = max_health

func get_health() -> int :
	return health

func get_health_max() -> int :
	return health_max

func set_health(value : int) -> void :
	health = value

func set_health_max(value :int) -> void :
	health_max = value

func is_health_max() -> bool :
	return health == health_max
