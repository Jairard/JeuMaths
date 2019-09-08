extends System

class_name HudSystem

func _get_used_components() -> Array:
	return [ComponentsLibrary.Health, ComponentsLibrary.Hud]

func _process_node(dt : float, components : Dictionary) -> void:
	
	var comp_health		 = 	components[ComponentsLibrary.Health] as HealthComponent
	var comp_hud	 = 	components[ComponentsLibrary.Hud] as HudComponent
	
#	comp_health.set_health(comp_hud.data_names["health"])
	
	
	comp_hud.data_names["health"] = comp_health.health

#	print (comp_hud.data_names["health"])