extends Area2D

func _ready():
	self.position.x = 725
	self.position.y =  425	

func _on_monster_body_entered(body):
	GLOBAL.pv_hero -= 10
	GLOBAL.emit_signal("pv_hero",GLOBAL.pv_hero)
	queue_free()

func death_monster():
	queue_free()
