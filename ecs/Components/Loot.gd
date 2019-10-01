extends Component

class_name LootComponent

var loots	: Dictionary
var name 	: Node2D
var _type 	: int
enum type 	{xp, health, damage}

func init(_loots : Dictionary) -> void:
	loots = _loots
	
func set_loot() : # -> Node2D:			
#	print (loots)
	var Sum : int
	for s in loots:
		Sum += loots[s]
	var r = RandomUtils.randi_to(Sum - 1)	
#	print (Sum)

	var sum_weight : int
	for clue in loots:
		sum_weight += loots[clue]
		if r <= sum_weight :
			_type = clue
			
func get_loot(): #	-> Node2D
	var ressource : Node2D
	var drop = type[_type]
	ressource = drop.instance()
	
	
	
	
	
	
	