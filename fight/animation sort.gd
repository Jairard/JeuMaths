extends RigidBody2D


func _ready():
	sort(self.position)
	pass


func _process(delta):
	pass


func sort(positio : Vector2) -> void :
	self.position = positio
	self.position.x += 70 
	$particul.emitting = true
	



func _on_Timer_timeout():
	queue_free()




