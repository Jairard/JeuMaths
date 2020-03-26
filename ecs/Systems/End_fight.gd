extends System

class_name EndfightSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Health, ComponentsLibrary.EmitPArticules]

func _get_optional_components() -> Array:
	return [ ComponentsLibrary.Node_Enemy, ComponentsLibrary.Node_Hero, ComponentsLibrary.Scoreglobal]

func _process_node(dt : float, components : Dictionary) -> void:

	var comp_health 		= components[ComponentsLibrary.Health] 				as HealthComponent
	var emit_comp		 	= components[ComponentsLibrary.EmitPArticules] 	 	as EmitParticulesComponent
	var node_hero			= components[ComponentsLibrary.Node_Hero]			as NodeHeroComponent
	var node_enemy			= components[ComponentsLibrary.Node_Enemy]			as NodeEnemyComponent
	var score_comp			= components[ComponentsLibrary.Scoreglobal] 		as ScoreglobalcounterComponent

	var current_health = comp_health.get_health()

	if current_health <= 0:
			var node = comp_health.get_node()
			emit_comp.set_emit(true)
			yield(node.get_parent().get_tree().create_timer(3.0), "timeout")
			if node_hero != null:
				FileBankUtils.defeats += 1
				comp_health.get_node().get_parent().get_tree().change_scene(FileBankUtils.loaded_scenes["death"])
			if node_enemy != null:			
				FileBankUtils.victories += 1
				FileBankUtils.scene_counter += 1
				comp_health.get_node().get_parent().get_tree().change_scene(FileBankUtils.loaded_scenes["rewards"])

