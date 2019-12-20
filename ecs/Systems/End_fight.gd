extends System

class_name EndfightSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Health, ComponentsLibrary.EndFight]
	
func _process_node(dt : float, components : Dictionary) -> void:
	
	var comp_health 		= components[ComponentsLibrary.Health] 		as HealthComponent
	var comp_end_fight 		= components[ComponentsLibrary.EndFight] 	as EndfightComponent
	
	var current_health = comp_health.get_health()
	if current_health <= 0:
		print ("node : ", comp_end_fight.get_node())
		comp_end_fight.set_end(true)

