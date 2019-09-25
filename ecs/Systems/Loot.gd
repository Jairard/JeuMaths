extends System

class_name LootSystem

onready var treasure 		= 	preload("res://characters/treasure.tscn")

func _get_used_components() -> Array:
	return [ComponentsLibrary.Loot, ComponentsLibrary.Nodegetid]

#func _get_system_dependencies() -> Array:
#	return [SystemsLibrary.Position]

func _process_node(dt : float, components : Dictionary) -> void:
	var loot_comp 	= 	components[ComponentsLibrary.Loot]			 as  LootComponent
	var node_comp 	= 	components[ComponentsLibrary.Nodegetid]		 as  NodegetidComponent
	

	if loot_comp.get_loot() == 1:
		print (1) 
		#add_child(treasure.instance())
	
	if loot_comp.get_loot() == 2:
		print (2)
		
	if loot_comp.get_loot() == 3:
		print (3)