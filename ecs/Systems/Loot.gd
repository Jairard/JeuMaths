extends System

class_name LootSystem

func _get_used_components() -> Array:
	return [ComponentsLibrary.Loot, ComponentsLibrary.Nodegetid]

#func _get_system_dependencies() -> Array:
#	return [SystemsLibrary.Position]

func _process_node(dt : float, components : Dictionary) -> void:
	var loot_comp 	= 	components[ComponentsLibrary.Loot]			 as  LootComponent
	var node_comp 	= 	components[ComponentsLibrary.Nodegetid]		 as  NodegetidComponent
	

	loot_comp.get_loot()