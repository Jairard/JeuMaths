extends KinematicBody2D


func _process(delta):
	if self.position.y >= 540 :
		queue_free()


