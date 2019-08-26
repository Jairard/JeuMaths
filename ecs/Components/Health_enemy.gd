extends Component

class_name HealthEnemyComponent

var health_enemy = 100
var health_enemy_max = 100

func get_health_hero(value : int) -> int :
	return health_enemy

func get_health_enemy_max(value : int) -> int :
	return health_enemy_max

func is_health_enemy_max() -> bool :
	if  health_enemy == health_enemy_max :
		return true
	else :
		return false
		
func set_health_enemy(value : int) -> void :
	health_enemy = value
	
func set_health_enemy_max(value :int) -> void :
	health_enemy_max = value
	
