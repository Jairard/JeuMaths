extends KinematicBody2D




func _ready():
	pass
	
func death(valeur):
	if valeur == 0:
		queue_free()	
	
#func _process(delta):
#	pass
