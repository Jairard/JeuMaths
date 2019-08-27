extends Particles2D

func _ready():
	self.emitting = true
	self.position = Vector2(1000,540)
	pass

func _process(delta):

	
	
	self.position.x -= 10
	if self.position.x <= 0  :
		queue_free()


func _on_Area2D_body_entered(body):
	GLOBAL.pv_hero -= 10
	GLOBAL.emit_signal("pv_hero",GLOBAL.pv_hero)
	queue_free()