extends System

class_name EndChronoSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Chrono]

func _process_node(dt : float, components : Dictionary) -> void:
	var chrono 			= components[ComponentsLibrary.Chrono] 			as ChronoComponent

	var timerNode = chrono.get_node().get_node("Timer")
	var timer_left = timerNode.get_time_left()
	if timer_left <= 1 :
		FileBankUtils.treasure += chrono.get_gold()
		if FileBankUtils.hide_tuto:
			Fade.change_scene(FileBankUtils.load_right_scene())
		else:
			Fade.change_scene(FileBankUtils.loaded_scenes["tuto_map"])
		ECS.request_unregister_system(SystemsLibrary.End_chrono)
