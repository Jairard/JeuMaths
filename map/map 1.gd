extends Node2D

onready var hero = preload("res://hero.tscn")
onready var ennemy = preload("res://Ennemy.tscn")



func _ready():
	print ("00000000000000000000000")
	spawn()
	pass


#func _process(delta):
#	pass


func spawn() :
	print ("111111111111111111111111")
	add_child(hero.instance())
	add_child(ennemy.instance())
	re_size()
	

func re_size():
	print("resize")
	#ennemy.tscn.resize(100,100,1)