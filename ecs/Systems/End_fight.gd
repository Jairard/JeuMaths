extends System

class_name EndfightSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Health]
	
func _process_node(dt : float, components : Dictionary) -> void:
	
	var comp_health 		= components[ComponentsLibrary.Health] as HealthComponent
	
	var current_health = comp_health.get_health()
	if current_health <= 0:
		pass

