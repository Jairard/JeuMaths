extends Component

class_name XpComponent

var current_xp	: int = 0
var max_xp 		: int = 100
var lvl 		: int = 0
 

func init(_current_xp : int, _lvl : int) -> void:
	current_xp 	= 	_current_xp
	lvl 		= 	_lvl

func get_xp() -> int :
	return current_xp

func set_xp(value : int) -> void :
	current_xp = value
	
func get_lvl() -> int :
	return lvl

func set_lvl(value : int) -> void :
	lvl = value
	
#func is_max_xp():							#system Xp
#	return current_xp >= max_xp 
#
#func lvl_up()
#		current_xp = 0
#		lvl += 1