extends Component

class_name LootComponent

var loots	: Dictionary
var name 	: Node2D

func init(_loots : Dictionary) -> void:
	loots = _loots
	
func __get_random_resource(loots : Dictionary) -> Resource: 			
	var Sum : int
	for s in loots:
		Sum += loots[s]
	var r = RandomUtils.randi_to(Sum - 1)	

	var sum_weight : int
	for key in loots:
		sum_weight += loots[key]
		if r <= sum_weight :
			return key
	return null
			
func get_loots() -> Node2D:
	var resource : Resource = __get_random_resource(loots)
	if resource == null:
		return null
	return resource.instance()
	
	
	
	
	
	
	