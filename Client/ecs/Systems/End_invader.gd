extends System

class_name EndInvaderSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Invader]

func _process_node(dt : float, components : Dictionary) -> void:
	var invader 			= components[ComponentsLibrary.Invader] 			as InvaderComponent

	var current_health = invader.get_health()
	if current_health == 0 :
		FileBankUtils.treasure += invader.get_gold()
		if FileBankUtils.hide_tuto:
			Fade.change_scene(FileBankUtils.loaded_scenes["chrono"])
		else:
			Fade.change_scene(FileBankUtils.loaded_scenes["tuto_chrono"])
		ECS.request_unregister_system(SystemsLibrary.End_invader)
