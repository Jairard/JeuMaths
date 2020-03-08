extends CanvasLayer

var is_changing_scene : bool = false


func change_scene(path):
	is_changing_scene = true
	$Control.show()
	$AnimationPlayer.play("scene_changer")
	yield($AnimationPlayer, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	$AnimationPlayer.play_backwards("scene_changer")
	yield($AnimationPlayer, "animation_finished")
	$Control.hide()
	is_changing_scene = false

func is_changing_scene() -> bool:
	return is_changing_scene

