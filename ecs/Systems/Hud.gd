extends System

class_name HudSystem

func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Collision]

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Hud]

func _get_optional_components() -> Array:
	return [ ComponentsLibrary.Treasure, ComponentsLibrary.Scoreglobal, ComponentsLibrary.Health, 
			ComponentsLibrary.Damage]

func _process_node(dt : float, components : Dictionary) -> void:

	var comp_health		 	= 	components[ComponentsLibrary.Health] 		as 	HealthComponent
	var comp_treasure		= 	components[ComponentsLibrary.Treasure] 		as 	TreasureComponent
	var comp_damage		 	= 	components[ComponentsLibrary.Damage] 		as	DamageComponent
	var comp_hud		 	= 	components[ComponentsLibrary.Hud] 			as	HudComponent
	var comp_score		 	= 	components[ComponentsLibrary.Scoreglobal] 	as	ScoreglobalcounterComponent

	if comp_health != null:
		comp_hud.update_displayed_health(dt)
		var current_health = comp_health.get_health()
		comp_hud.set_health(current_health)
		var max_health = comp_health.get_health_max()
		comp_hud.set_health_max(max_health)

	if comp_treasure != null:
		var current_treasure = comp_treasure.get_treasure()
		comp_hud.set_treasure(current_treasure)

	if comp_damage != null:
		var current_damage = comp_damage.get_damage()
		comp_hud.set_damage(current_damage)

	if comp_score != null:
		comp_hud.set_good_answer(FileBankUtils.good_answer)
		comp_hud.set_wrong_answer(FileBankUtils.wrong_answer)		
		comp_hud.set_victories(FileBankUtils.victories)
		comp_hud.set_defeats(FileBankUtils.defeats)		
		var current_score = comp_score.compute_score()
		comp_hud.set_score(current_score)


		



