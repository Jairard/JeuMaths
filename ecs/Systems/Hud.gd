extends System

class_name HudSystem

func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Collision]
	
func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Health, ComponentsLibrary.Hud, ComponentsLibrary.Damage]

func _get_optional_components() -> Array:
	return [ ComponentsLibrary.Treasure, ComponentsLibrary.Xp, ComponentsLibrary.Scoregolbal, ComponentsLibrary.Treasure]
			
func _process_node(dt : float, components : Dictionary) -> void:

	var comp_health		 	= 	components[ComponentsLibrary.Health] 		as 	HealthComponent
	var comp_treasure		= 	components[ComponentsLibrary.Treasure] 		as 	TreasureComponent
	var comp_xp				= 	components[ComponentsLibrary.Xp] 			as 	XpComponent
	var comp_damage		 	= 	components[ComponentsLibrary.Damage] 		as	DamageComponent
	var comp_hud		 	= 	components[ComponentsLibrary.Hud] 			as	HudComponent
	var comp_score		 	= 	components[ComponentsLibrary.Scoregolbal] 	as	ScoreglobalcounterComponent
	
	if comp_health != null:
		var current_health = comp_health.get_health()
		comp_hud.set_health(current_health)
		var max_health = comp_health.get_health_max()
		comp_hud.set_health_max(max_health)	
	
	if comp_treasure != null:
		var current_treasure = comp_treasure.get_treasure()
		comp_hud.set_treasure(current_treasure)
	
	if comp_xp != null:
		var current_xp = comp_xp.get_xp()
		comp_hud.set_xp(current_xp)

		var current_lvl = comp_xp.get_lvl()
		comp_hud.set_level(current_lvl)
		
	if comp_damage != null:
		var current_damage = comp_damage.get_damage()
		comp_hud.set_damage(current_damage)
	
	if comp_score != null:
		var current_score = comp_score.get_boss_killed() * (comp_score.get_good_answer() / comp_score.get_wrong_answer()) * 1000
		comp_hud.set_score(current_score)
		
	
	
	
	
