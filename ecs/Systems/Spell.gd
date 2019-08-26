extends System

class_name HealthSystem

func _get_used_components() -> Array:
	return [ComponentsLibrary.Health_hero, ComponentsLibrary.Health_enemy, ComponentsLibrary.Spell]

func _process_node(dt : float, components : Dictionary) -> void:
	
	var comp_hero = components[ComponentsLibrary.Health_hero] as HealthHeroComponent
	var comp_enemy = components[ComponentsLibrary.Health_enemy] as HealthEnemyComponent
	var spl = components[ComponentsLibrary.Spells] as SpellComponent

	if spl.get_spell() == spl.spells.spell_1 :
		comp_enemy.health_enemy -= 10
		pass
		
	if spl.get_spell() == spl.spells.spell_2 :
		comp_hero.health_hero -= 10
		pass
	