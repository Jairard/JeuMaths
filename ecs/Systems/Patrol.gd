extends System

class_name PatrolSystem


func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Patrol, ComponentsLibrary.Position]

func _get_optional_components() -> Array:
	return [ComponentsLibrary.Animation]
	
func _process_node(dt : float, components : Dictionary) -> void:
	var comp_patrol  = 	components[ComponentsLibrary.Patrol] as PatrolComponent
	var comp_anim	 = 	components[ComponentsLibrary.Animation] as AnimationComponent
	var comp_pos	 = 	components[ComponentsLibrary.Position] as PositionComponent


	if comp_anim != null: 
		comp_anim.play(comp_anim.anim.right)

	var previous_ratio = comp_patrol.get_ratio()
	var delta_ratio = dt/comp_patrol.get_timer()
	var current_ratio = previous_ratio + delta_ratio
	var clamped_ratio = min(1, current_ratio)
	var new_position = lerp(comp_patrol.get_pos_start(), comp_patrol.get_pos_end(), clamped_ratio)
	
	comp_pos.set_position(new_position)
	comp_patrol.set_ratio(clamped_ratio)
