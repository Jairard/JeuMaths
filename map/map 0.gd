extends Node2D


onready var ennemy = preload("res://ennemy.tscn")
onready var hero = preload("res://hero.tscn")
onready var coin = preload("res://coin.tscn")


func _ready():
	charger_intro()

	


#func _process(delta):
#	pass

func charger_intro() :
	add_child(ennemy.instance())
	add_child(hero.instance())
	add_child(coin.instance())
	

func combat(valeur) :
	if valeur == 0 :
		get_tree().change_scene("res://map/map 1.tscn")
		

