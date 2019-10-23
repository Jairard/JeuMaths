extends Component

class_name SpellComponent

enum spells {fireball, arrow, sword, none}

var init_spell = spells.none 

func get_spell() -> bool :
	return init_spell
	
func set_spell(spells) -> void : 	# dir : dir 
		init_spell = spells

