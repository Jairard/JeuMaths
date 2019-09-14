extends Node2D

onready var hero  	= 	preload("res://characters/hero.tscn")
onready var enemy 	= 	preload("res://characters/Ennemy.tscn")
onready var answer 	= 	preload("res://characters/Answer.tscn")


func _ready():
	add_child(hero.instance())
	add_child(enemy.instance())
	add_child(answer.instance())
