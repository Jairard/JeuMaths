extends Component

class_name SpellComponent

# spell_1 & spell_2 are not really explicit names
# TODO: rename spell_1 & spell_2 with comething like "Fireball" or "avada_kedavra"
enum spells {spell_1, spell_2, none}

var init_spell = spells.none 

func get_spell() -> bool :
	return init_spell
	
func set_spell(spells) -> void : 	# dir : dir 
		init_spell = spells

