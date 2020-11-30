extends Node2D


func cast():
	# To start the spell, we play the animation and trigger the particles !
	$AnimationPlayer.play("cast_right");
	$Sparks.emitting = true

func _on_animation_finished(anim_name):
	clean_up()

func _process(delta):
	# Check if the spell has hit an enemy
	if $Fireball/oeil_droit.is_colliding() == true:
		# TODO emit signal or do something
		# We have to  clean up to avoid multiple signals to be sent
		clean_up()

func clean_up():
	# This will delete the node as we don't need it anymore
	queue_free()
