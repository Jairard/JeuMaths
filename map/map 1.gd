extends Node2D

onready var hero = preload("res://hero.tscn")
#onready var ennemi preload("")



func _ready():
	print ("00000000000000000000000")
	spawn()
	pass


#func _process(delta):
#	pass


func spawn() :
	print ("111111111111111111111111")
	add_child(hero.instance())
	