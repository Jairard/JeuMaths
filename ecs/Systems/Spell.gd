extends System

class_name SpellSystem

func _get_used_components() -> Array:
	return [ComponentsLibrary.Spell]

func _process_node(dt : float, components : Dictionary) -> void:
	var spl = components[ComponentsLibrary.Spell] as SpellComponent

	if spl.get_spell() == spl.spells.fireball :
		pass

	if spl.get_spell() == spl.spells.arrow :
		pass
