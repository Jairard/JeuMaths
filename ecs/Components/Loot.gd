extends Component

class_name LootComponent

enum type_loot  {
	health = 0
	gold = 1
	xp = 2
	}

var type : int 
var dict : Dictionary

func init(_Name : Node2D, _health : int, _gold : int, _xp : int) -> void:
	dict = {Name = _Name, health = _health, gold = _gold, xp = _xp}

func get_loot() -> int:			
                                                       

	
	var r = RandomUtils.randi_to(3)		
	if r >=0 && r<33:				#call randiUtils
		pass			# init() dict (preload entity on map, weight) dans map
							
	if r>=33 && r<66:
		pass

	if r>=66 && r<101:
		pass
	return r	