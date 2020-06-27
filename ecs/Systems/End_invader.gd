extends System

class_name EndInvaderSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Invader]

func _process_node(dt : float, components : Dictionary) -> void:
	var invader 			= components[ComponentsLibrary.Invader] 			as InvaderComponent

	var current_health = invader.get_health()
	if current_health == 0 :
		FileBankUtils.treasure += invader.get_gold()
#		var scene = invader.get_node()
#		var treasure = scene.hud
#		var test = treasure.get_node("treasure")
#		test.a_scale(Vector2(3,3))
#		var camera = scene.get_node("Camera2D")
#		camera._set_current(true)
#		CameraUtils.set_camera_root(scene)
#		CameraUtils.set_offset(Vector2(400, -720))
#		CameraUtils.set_zoom(0.1)
#		scene.apply_scale(Vector2(1.5, 1.5))

		Fade.change_scene(FileBankUtils.load_right_scene())

