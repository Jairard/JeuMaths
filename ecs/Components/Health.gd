extends Component

class_name HealthComponent

# TODO:
# - call the init method just after adding the component
var health = 0
var health_max = 0

func init(current_health : int, max_health : int) -> void :
	health = current_health
	health_max = max_health

#func get_health_hero(value : int) -> int :
#	return health
#
#func get_health_enemy_max(value : int) -> int :
#	return health_max
#
#func is_health_enemy_max() -> bool :
#	if  health == health_max :
#		return true
#	else :
#		return false
#
#func set_health(value : int) -> void :
#	health = value
#
#func set_health_max(value :int) -> void :
#	health_max = value
	
