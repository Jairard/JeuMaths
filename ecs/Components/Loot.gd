extends Component

class_name LootComponent

enum type_loot  {
	health = 0
	gold = 1
	xp = 2
	}

var type : int 
var r : int

func get_percent() -> int:
	randomize()
	r = randi() % 100	
	return r
	
func set_percent() -> void:
	if r >=0 && r<33:
		type = type_loot[0]
		
	if r>=33 && r<66:
		type = type_loot[1]
		
	if r>=66 && r<101:
		type = type_loot[2]
	