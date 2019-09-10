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
	var health_comp = ECS.__get_component(body.get_instance_id(), ComponentsLibrary.Health) as HealthComponent # in collision system
	if health_comp != null : 
		health_comp.set_health(health_comp.get_health() - 10)
#	GLOBAL.pv_hero -= 10
#	GLOBAL.emit_signal("pv_hero",GLOBAL.pv_hero)
	queue_free()