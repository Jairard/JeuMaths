extends Component

class_name LootComponent

enum type_loot  {
	health = 0
	gold = 1
	xp = 2
	}

var type 	: int 
var dict 	: Dictionary
var name 	: Node2D
var health 	: int
var gold 	: int
var xp 		: int
var loot 	: int = 0

func init(_name : Node2D, _health : int, _gold : int, _xp : int) -> void:
	name 	= _name
	health 	= _health
	gold 	= _gold
	xp 		=_xp

func get_loot() -> int:			
                                                       
#	if dict.size() != null : 
	dict = {Name = name, Health = health, Gold = gold, Xp = xp}
	var r = RandomUtils.randi_to(100)		

	if r >=0 && r< health:				#call randiUtils
		loot = 1
							
	if r>= health && r< health + gold:
		loot = 2

	if r>= health + gold && r< health + gold + xp:
		loot = 3 
	
	return loot	