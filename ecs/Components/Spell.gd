extends Component

class_name SpellComponent

var spells  : Dictionary = {}

func init(_spells : Dictionary) -> void:
	spells = _spells

func get_spell(name : String) -> Node2D :				
	if spells.has(name):
		return spells[name].instance()
	return null
