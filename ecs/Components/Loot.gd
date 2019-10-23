extends Component

class_name LootComponent

var loots			: Array
var loot_generator 	: Node2D

func get_loot_generator() -> Node2D:
	return loot_generator

func init(_loots : Array, _loot_generator : Node2D) -> void:
	loots = _loots
	loot_generator = _loot_generator
	
func __get_random_resource(loots : Dictionary) -> Resource: 			
	var Sum : int = 0
	for s in loots:
		Sum += loots[s]
	var r = RandomUtils.randi_to(Sum - 1)	

	var sum_weight : int = 0
	for key in loots:
		sum_weight += loots[key]
		if r <= sum_weight :
			return key
	return null
			
func get_loots() -> Array:
	var loots_Array = []
	for x in loots:
		var resource : Resource = __get_random_resource(x)
		if resource != null: 
			loots_Array.append(resource.instance())
	return loots_Array

	
	
	
	
	
	