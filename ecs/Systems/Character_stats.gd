extends System

class_name CharacterstatsSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Stats, ComponentsLibrary.Health, ComponentsLibrary.Damage, ComponentsLibrary.Xp]
	
func _process_node(dt : float, components : Dictionary) -> void:
	
	var comp_stats	= components[ComponentsLibrary.Stats] 	as CharacterstatsComponent
	var comp_health	= components[ComponentsLibrary.Health] 	as	HealthComponent
	var comp_damage	= components[ComponentsLibrary.Damage] 	as DamageComponent
	var comp_xp	= components[ComponentsLibrary.Xp] 			as XpComponent

	comp_health.set_health_max(comp_stats.stats["health"])
	comp_health.set_health(comp_stats.stats["health"])
	comp_damage.set_damage(comp_stats.stats["damage"])
	comp_xp.set_xp(comp_stats.stats["xp"])
