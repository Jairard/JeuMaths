extends Node2D

onready var hero 			= 	preload("res://Src/Ingame/characters/hero.tscn")

func _ready():
	
	var heroNode = hero.instance()
	add_child(heroNode)
	heroNode.set_name("hero")