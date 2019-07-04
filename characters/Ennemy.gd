extends KinematicBody2D


#signal damage(valeur)

func _ready():
	GLOBAL.connect("win", self, "death")
	pass
	
	
	
	
func death(valeur):
	print ("mort")
	queue_free()
	

	
func _process(delta):
	if $RayCast_gauche.is_colliding() == true: #or $RayCast_gauche.is_colliding() or $RayCast_droite.is_colliding() or $RayCast_haut.is_colliding() :
		print ("test collision") 
#		emit_signal("damage",0)
	pass


