extends Node2D

onready var hero 			= 	preload("res://Src/Ingame/characters/hero.tscn")

func _ready():
	var heroNode = hero.instance()
	add_child(heroNode)
	heroNode.set_name("hero")

func _on_Button_pressed():
	get_tree().change_scene("res://Src/Outgame/Multiscenes.tscn")
