extends RigidBody2D


func _ready():
	pass # Replace with function body.



#func _process(delta):
#	pass


func sort(positio : Vector2) -> void :
	self.position = positio
	self.position.x += 70 
	$particul.emitting = true
	
	

func _on_Timer_timeout():
	queue_free()



