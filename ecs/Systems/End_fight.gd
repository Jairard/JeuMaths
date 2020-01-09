extends System

class_name EndfightSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Health, ComponentsLibrary.EmitPArticules]
	
func _process_node(dt : float, components : Dictionary) -> void:
	
	var comp_health 		= components[ComponentsLibrary.Health] 					as HealthComponent
	var emit_comp		 	= 	components[ComponentsLibrary.EmitPArticules] 	 	as  EmitParticulesComponent

	var current_health = comp_health.get_health()
	if current_health <= 0:
		var new_scene = FileBankUtils.loaded_scenes["map_fire"]
		var node = comp_health.get_node()
		emit_comp.set_emit(true)
#		node.get_tree().change_scene(new_scene)
		

