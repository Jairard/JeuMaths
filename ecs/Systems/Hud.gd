extends System

class_name HudSystem

func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Collision]

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Hud_fight]

func _get_optional_components() -> Array:
	return [ ComponentsLibrary.Treasure, ComponentsLibrary.Scoreglobal, ComponentsLibrary.Health, 
			ComponentsLibrary.Damage, ComponentsLibrary.Hud_treasure,ComponentsLibrary.Hud_map,
			ComponentsLibrary.Hud_stats_popup]

func _process_node(dt : float, components : Dictionary) -> void:

	var comp_health		 	= 	components[ComponentsLibrary.Health] 			as 	HealthComponent
	var comp_treasure		= 	components[ComponentsLibrary.Treasure] 			as 	TreasureComponent
	var comp_damage		 	= 	components[ComponentsLibrary.Damage] 			as	DamageComponent
	var comp_score		 	= 	components[ComponentsLibrary.Scoreglobal] 		as	ScoreglobalcounterComponent
	var comp_hud_treasure	= 	components[ComponentsLibrary.Hud_treasure] 		as	HudTreasureComponent
	var comp_hud_fight		= 	components[ComponentsLibrary.Hud_fight] 		as	HudFightComponent
	var comp_hud_map		= 	components[ComponentsLibrary.Hud_map] 			as	HudMapComponent
	var comp_hud_stats_popup= 	components[ComponentsLibrary.Hud_stats_popup] 	as	HudStatsPopupComponent

	if comp_health != null:
		comp_hud_fight.update_displayed_health(dt)	
		var max_health = comp_health.get_health_max()
		comp_hud_fight.set_health_max(max_health)
		var current_health = comp_health.get_health()
		comp_hud_fight.set_health(current_health)
	
		if comp_score != null:	
			var current_score = comp_score.compute_score()
			comp_hud_map.set_score(current_score)
		
	if comp_damage != null:
		var current_damage = comp_damage.get_damage()
		comp_hud_fight.set_damage(current_damage)

	if comp_treasure != null:
		var current_treasure = comp_treasure.get_treasure()
		comp_hud_treasure.set_treasure(current_treasure)


	if comp_score != null and comp_hud_stats_popup != null:
		comp_hud_stats_popup.set_good_answer(FileBankUtils.good_answer)
		comp_hud_stats_popup.set_wrong_answer(FileBankUtils.wrong_answer)		
		comp_hud_stats_popup.set_victories(FileBankUtils.victories)
		comp_hud_stats_popup.set_defeats(FileBankUtils.defeats)		
