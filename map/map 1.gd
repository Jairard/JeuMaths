extends Node2D

onready var player = preload("res://hero.tscn")
#onready var ennemi preload("")



func _ready():
	print ("00000000000000000000000")
	spawn()
	pass


#func _process(delta):
#	pass


func spawn() :
	print ("111111111111111111111111")
	var objet
	objet = player.instance()
	objet.position = Vector2(100,100)
	add_child(objet)