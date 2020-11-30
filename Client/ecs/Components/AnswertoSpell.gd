extends Component

class_name AnswertoSpellComponent

enum property {name, target, damage}
var spell_properties : Dictionary = {}

func get_spell_properties(key) -> Dictionary:
	if spell_properties.has(key):
		return spell_properties[key]
	return {}

func get_spell_name(key) -> String:
	var spell_properties = get_spell_properties(key)
	if spell_properties.has(property.name):
		return spell_properties[property.name]
	return ""

func get_spell_target(key) -> Node2D:
	var spell_properties = get_spell_properties(key)
	if spell_properties.has(property.target):
		return spell_properties[property.target]
	return null

func get_spell_damage(key) -> int:
	var spell_properties = get_spell_properties(key)
	if spell_properties.has(property.damage):
		return spell_properties[property.damage]
	return 0

func init(spell_name : Dictionary) -> void :
	spell_properties = spell_name
