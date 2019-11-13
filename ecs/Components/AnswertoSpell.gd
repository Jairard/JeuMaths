extends Component

class_name AnswertoSpellComponent

var spells : Dictionary = 	{}

func get_spell_name(key) -> String: 
	if spells.has(key):
		return spells[key]
	return ""
	
func init(spell_name : Dictionary) -> void :
	spells = spell_name
