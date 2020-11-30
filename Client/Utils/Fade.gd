extends CanvasLayer

func change_scene(path, delay = 0.5):
	yield(get_tree().create_timer(delay), "timeout")
	$ColorRect.show()
	$AnimationPlayer.play("fade")
	yield($AnimationPlayer, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	$AnimationPlayer.play_backwards("fade")
	yield($AnimationPlayer, "animation_finished")
	$ColorRect.hide()

func checkpoint(node : Node2D, position : Vector2, delay = 0):
	yield(get_tree().create_timer(delay), "timeout")
	$ColorRect.show()
	$AnimationPlayer.play("fade")
	yield($AnimationPlayer, "animation_finished")
	node.set_position(position)
	$AnimationPlayer.play_backwards("fade")
	yield($AnimationPlayer, "animation_finished")
	$ColorRect.hide()
