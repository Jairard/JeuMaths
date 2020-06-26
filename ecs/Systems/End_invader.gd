extends System

class_name EndInvaderSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Invader]

func _process_node(dt : float, components : Dictionary) -> void:
	var invader 			= components[ComponentsLibrary.Invader] 			as InvaderComponent

	var current_health = invader.get_health()
	if current_health == 0 :
		FileBankUtils.treasure += invader.get_gold()
		var scene = invader.get_node()
		var camera = scene.get_node("Camera2D")
		camera._set_current(true)
		CameraUtils.set_camera_root(scene)
		CameraUtils.set_offset(Vector2(550, 80))
		CameraUtils.set_zoom(0.5)
		print(scene)
#		Fade.change_scene(FileBankUtils.loaded_scenes["rewards"])

