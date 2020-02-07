extends Node2D


func _process(delta):
	if $spell/oeil_gauche.is_colliding() == true :
		clean_up()


func cast() :
	$AnimationPlayer.play("cast_left")



func _on_AnimationPlayer_animation_finished(anim_name):
	clean_up()

func clean_up():
	queue_free()
