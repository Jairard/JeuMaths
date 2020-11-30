extends KinematicBody2D

func _ready():
	self.position.x = 725
	self.position.y =  425

func death_monster():
	queue_free()
