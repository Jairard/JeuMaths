extends Component

class_name LootComponent

var type 	: int 
var loots	: Dictionary
var name 	: Node2D

func init(_loots : Dictionary) -> void:
	loots = _loots

func get_loot() : # -> Node2D:			
	var ressource : Node2D
	
	var Sum : int
	for s in loots:
		Sum += loots[s]
	var r = RandomUtils.randi_to(Sum - 1)	

	var sum_weight : int
	for clue in loots:
		sum_weight += loots[clue]
		if r <= sum_weight :
			return clue
			
	
