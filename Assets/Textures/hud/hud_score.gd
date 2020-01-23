extends Node2D

onready var treasure = preload("res://Src/Ingame/characters/treasure.tscn")

func _ready():
	add_child(treasure.instance())
	
func get_score() -> Label:
	return $CanvasLayer/HBoxContainer/MarginContainer/Score		as Label
	
func get_treasure() -> Label :
	return $CanvasLayer/HBoxContainer2/MarginContainer/treasure 	as Label