extends System

class_name EndInvaderSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Invader, ComponentsLibrary.End_invader]

func _process_node(dt : float, components : Dictionary) -> void:
	var invader 			= components[ComponentsLibrary.Invader] 			as InvaderComponent
	var end_comp			= components[ComponentsLibrary.End_invader]			as EndInvaderComponent

	var current_health = invader.get_health()
	if current_health == 0 and end_comp.get_end() == true:
		FileBankUtils.treasure += invader.get_gold()
		end_comp.set_end(false)
#		Fade.change_scene(FileBankUtils.loaded_scenes["rewards"])

