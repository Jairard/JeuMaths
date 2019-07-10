extends KinematicBody2D


onready var lot   = preload("res://fight/loot_monstre.tscn")

func _ready():
	GLOBAL.connect("win", self, "death")
	pass
	
	
	
	
func death(valeur):
	queue_free()
	var pos = self.position
	var i = lot.instance()
	var boo = i.start(pos)
	if boo :
		get_parent().add_child(i)
		i.connect("loot", GLOBAL, "item_loot")
	
	

	
func _process(delta):
	pass

