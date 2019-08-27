extends Component

# TODO: see HealthEnemyComponent
class_name HealthHeroComponent

var health_hero = 100
var health_hero_max = 100

func get_health_hero(value : int) -> int :
	return health_hero

func get_health_hero_max(value : int) -> int :
	return health_hero_max

func is_health_hero_max() -> bool :
	if  health_hero == health_hero_max :
		return true
	else :
		return false
		
func set_health_hero(value : int) -> void :
	health_hero = value
	
func set_health_hero_max(value :int) -> void :
	health_hero_max = value
	
