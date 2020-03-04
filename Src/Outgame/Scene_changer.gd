extends CanvasLayer

func change_scene(path):
	$Control.show()
	$AnimationPlayer.play("scene_changer")
	yield($AnimationPlayer, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	$AnimationPlayer.play_backwards("scene_changer")
	yield($AnimationPlayer, "animation_finished")
	$Control.hide()
	
