extends Component

# The component should be generic and not depend on the entity
# TODO:
# - rename to HealthComponent
# - delete HealthHeroComponent
class_name HealthEnemyComponent

# Since the component can be used by anyone, the default values should
# not be initialized to a specific value, but set at initialisation
# TODO:
# - initialize values to 0
# - add an init(current_health : int, max_health : int) -> void  method
# - call the init method just after adding the component
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
	
