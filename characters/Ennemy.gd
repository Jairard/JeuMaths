extends KinematicBody2D

onready var lot   = preload("res://fight/loot_monstre.tscn")

func _ready():
	GLOBAL.connect("win", self, "death")
		
func death(valeur):
	var pos = self.position
	var i = lot.instance()
	i.start(pos)
#	if boo :
	get_parent().add_child(i)
	queue_free()

	
#func _process(delta):
#	pass

