extends System

class_name HudEnemySystem

func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Collision]
	
func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Health, ComponentsLibrary.Hud, ComponentsLibrary.Treasure,
		  	 ComponentsLibrary.Xp, ComponentsLibrary.Damage]

func _process_node(dt : float, components : Dictionary) -> void:
	
	var comp_health		 	= 	components[ComponentsLibrary.Health] 	as 	HealthComponent
	var comp_hud		 	= 	components[ComponentsLibrary.Hud] 		as	HudComponent
	
	var current_health = comp_health.get_health()
	comp_hud.set_health(current_health)
