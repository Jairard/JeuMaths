extends System

class_name HealthSystem

func _get_used_components() -> Array:
	return [ComponentsLibrary.Health, ComponentsLibrary.Spell]

func _process_node(dt : float, components : Dictionary) -> void:
	
	var comp = components[ComponentsLibrary.Health] as HealthComponent
	var spl = components[ComponentsLibrary.Spells] as SpellComponent

	if spl.get_spell() == spl.spells.fireball :
		comp.health -= 10
		pass

	if spl.get_spell() == spl.spells.spell_2 :
		comp_hero.health -= 10
		pass
	