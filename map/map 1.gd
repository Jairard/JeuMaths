extends Node2D

onready var hero = preload("res://hero.tscn")
onready var ennemy = preload("res://Ennemy.tscn")


func _ready():
	spawn()
	pass


#func _process(delta):
#	pass


func spawn() :
	add_child(hero.instance())
	add_child(ennemy.instance())
	re_size()
	

func re_size():
	print("resize")
	#ennemy.tscn.resize(100,100,1)

func _on_Button_pressed():
	get_tree().change_scene("res://map/map 0.tscn")
	pass # Replace with function body.
