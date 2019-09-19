extends Component

class_name LootComponent

enum type_loot  {
	health = 0
	gold = 1
	xp = 2
	}

var type : int 

#func get_percent() -> int:
#	r = randi() % 100							#utils randi
#	return r
#
#func set_percent() -> void:			#get_loot()
#	if r >=0 && r<33:				#call randiUtils
#		type = type_loot[0]			# init() dict (preload entity on map, weight) dans map
#
#	if r>=33 && r<66:
#		type = type_loot[1]
#
#	if r>=66 && r<101:
#		type = type_loot[2]
	