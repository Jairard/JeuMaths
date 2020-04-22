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

		if comp_hud_fight._health_value.value > 0:
			comp_hud_fight._health_label.text = "%s / %s" % [comp_health.health,  comp_hud_fight.get_max_health()]
		if comp_hud_fight._health_value.value <= 0:
			comp_hud_fight._health_label.text = str(0)

		var global_ratio = (float(comp_health.health)  / comp_hud_fight.get_max_health())
		var yellow = Color("f1ff08")
		var green = Color("14e114")
		var orange = Color("ffad00")
		var red = Color("e11e1e")
		var black = Color("6f0000")

		if global_ratio >= 0.75:
			var local_ratio = 4*global_ratio - 3
			var color = lerp(yellow, green, local_ratio)
			comp_hud_fight._health_value.set_tint_progress(color)

		elif global_ratio >= 0.5 and global_ratio < 0.75 :
			var local_ratio = 4*global_ratio - 2
			var color = lerp(orange, yellow, local_ratio)
			comp_hud_fight._health_value.set_tint_progress(color)

		elif global_ratio >= 0.25 and global_ratio < 0.5 :
			var local_ratio = 4*global_ratio - 1
			var color = lerp(red, orange, local_ratio)
			comp_hud_fight._health_value.set_tint_progress(color) 

		elif global_ratio < 0.25 :
			var local_ratio = 4*global_ratio 
			var color = lerp(black, red, local_ratio)
			comp_hud_fight._health_value.set_tint_progress(color) 
#			if comp_score != null:	
#				var current_score = comp_score.compute_score()
#				comp_hud_fight.set_score(current_score)

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
