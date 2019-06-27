extends RigidBody2D

onready var valeur = Vector2()

func _ready():
	
	pass



#func _process(delta):
#	pass


func sort(positio : Vector2) -> void :
	self.position = positio
	self.position.x += 70 
	$particul.emitting = true
		
	
func position_hero(valeur):
	get_parent().sort(valeur)

func _on_Timer_timeout():
	position_hero(valeur)
	queue_free()


