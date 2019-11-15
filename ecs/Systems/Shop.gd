extends System

class_name ShopSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Health, ComponentsLibrary.Damage , ComponentsLibrary.Xp]

func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Move]

func _process_node(dt : float, components : Dictionary) -> void:
	var health_comp		= 	components[ComponentsLibrary.Health] 	 	 as  HealthComponent
	var dmg_comp		= 	components[ComponentsLibrary.Damage] 	 	 as  DamageComponent
	var xp_comp		 	= 	components[ComponentsLibrary.Xp] 	 		 as  XpComponent

	#if button_health pressed :
	health_comp.set_health(health_comp.get_health() + 10)
	
	#if button_damage pressed :
	dmg_comp.set_damage(dmg_comp.get_damage() + 10)
	
	#if button_xp pressed :
	xp_comp.set_xp(xp_comp.get_xp() + 10)