extends System

class_name HudSystem

func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Collision]
	
func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Health, ComponentsLibrary.Hud, ComponentsLibrary.Treasure,
		  	 ComponentsLibrary.Xp, ComponentsLibrary.Damage]

func _process_node(dt : float, components : Dictionary) -> void:
	
	var comp_health		 	= 	components[ComponentsLibrary.Health] 	as 	HealthComponent
	var comp_treasure		= 	components[ComponentsLibrary.Treasure] 	as 	TreasureComponent
	var comp_xp				= 	components[ComponentsLibrary.Xp] 		as 	XpComponent
	var comp_damage		 	= 	components[ComponentsLibrary.Damage] 	as	DamageComponent
	var comp_hud		 	= 	components[ComponentsLibrary.Hud] 		as	HudComponent
	
	var current_health = comp_health.get_health()
	comp_hud.set_health(current_health)
	
	var current_treasure = comp_treasure.get_treasure()
	comp_hud.set_treasure(current_treasure)
	
	var current_xp = comp_xp.get_xp()
	comp_hud.set_xp(current_xp)
	
	var current_lvl = comp_xp.get_lvl()
	comp_hud.set_level(current_lvl)

	var current_damage = comp_damage.get_damage()
	comp_hud.set_damage(current_damage)
	
	
	
	
	
	
	
	
