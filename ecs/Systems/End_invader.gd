extends System

class_name EndInvaderSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Invader]

func _process_node(dt : float, components : Dictionary) -> void:
	var invader 			= components[ComponentsLibrary.Invader] 			as InvaderComponent

	var current_health = invader.get_health()
	if current_health == 0 :
		FileBankUtils.treasure += invader.get_gold()
		print("lose")
#		Fade.change_scene(FileBankUtils.loaded_scenes["rewards"])

