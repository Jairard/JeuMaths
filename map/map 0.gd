extends Node2D

onready var intro = preload("res://jeu.tscn")
onready var hero = preload("res://hero.tscn")
#onready var enemi = preload("res://ennemi.tscn")

func _ready():
	charger_intro()
	pass # Replace with function body.
	print ("BITANE")


#func _process(delta):
#	pass

func charger_intro() :
	print ("2222222222222222222222222")
	add_child(intro.instance())
	add_child(hero.instance())
	

func combat(valeur) :
	if valeur == 0 :
		var ret = get_tree().change_scene("res://map/map 1.tscn")
