extends RigidBody2D

onready var valeur = Vector2()

func _ready():
	sort(self.position)
	pass



#func _process(delta):
#	pass


func sort(positio : Vector2) -> void :
#	get_parent().get_node("hero").add_spell(self.position)
	self.position = positio
	self.position.x += 70 
	$particul.emitting = true
	
		
	
#func position_hero(valeur):
#	get_parent().sort(valeur)

func _on_Timer_timeout():
	
	queue_free()


