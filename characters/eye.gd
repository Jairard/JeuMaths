extends Area2D


func _ready():
	pass 


func _process(delta):

	self.position.x -= 10
	if self.position.x <= -1450  :
		queue_free()


func _on_Area2D_body_entered(body):
	GLOBAL.pv_hero -= 10
	GLOBAL.emit_signal("pv_hero",GLOBAL.pv_hero)
	queue_free()


