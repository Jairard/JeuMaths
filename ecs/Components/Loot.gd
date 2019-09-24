extends Component

class_name LootComponent

enum type_loot  {
	health = 0
	gold = 1
	xp = 2
	}

var type : int 
var dict : Dictionary
var name : Node2D
var health : int
var gold : int
var xp : int

func init(_name : Node2D, _health : int, _gold : int, _xp : int) -> void:
	name 	= _name
	health 	= _health
	gold 	= _gold
	xp 		=_xp

func get_loot() -> int:			
                                                       
#	if dict.size() != null : 
	dict = {Name = name, Health = health, Gold = gold, Xp = xp}
	var r = RandomUtils.randi_to(100)		
	print (r)
	if r >=0 && r< health:				#call randiUtils
		print ("health")
		pass			# init() dict (preload entity on map, weight) dans map
							
	if r>= health && r< health + gold:
		print ("gold")
		pass

	if r>= health + gold && r< 100:
		print ("xp")
		pass
	return r	