extends System

class_name EndfightSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Health, ComponentsLibrary.EmitPArticules]
	
func _get_optional_components() -> Array:
	return [ ComponentsLibrary.Node_Enemy, ComponentsLibrary.Node_Hero]
	
func _process_node(dt : float, components : Dictionary) -> void:
	
	var comp_health 		= components[ComponentsLibrary.Health] 				as HealthComponent
	var emit_comp		 	= components[ComponentsLibrary.EmitPArticules] 	 	as EmitParticulesComponent
	var node_hero			= components[ComponentsLibrary.Node_Hero]			as NodeHeroComponent
	var node_enemy			= components[ComponentsLibrary.Node_Enemy]			as NodeEnemyComponent

	var current_health = comp_health.get_health()
	
	if current_health <= 0:
			var scene_rewards 	= FileBankUtils.loaded_scenes["rewards"]
			var scene_reset		= FileBankUtils.loaded_scenes["map_fire"]
			var node = comp_health.get_node()
			emit_comp.set_emit(true)
			yield(node.get_parent().get_tree().create_timer(3.0), "timeout")
			if node_hero != null:
				node.get_tree().change_scene(scene_reset)
			if node_enemy != null:
				node.get_tree().change_scene(scene_rewards)
				
			

