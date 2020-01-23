extends Node2D

onready var treasure = preload("res://Src/Ingame/characters/treasure.tscn")

func _ready():
	add_child(treasure.instance())
	
func get_score() -> Label:
	return $CanvasLayer/HBoxContainer/MarginContainer/Score		as Label
	
func get_treasure() -> Label :
	return $CanvasLayer/HBoxContainer2/MarginContainer/treasure 	as Label

func _on_Button_pressed():
#	var new_scene = FileBankUtils.loaded_scenes["shop"]
#	get_tree().change_scene("new_scene")
	get_tree().change_scene("res://Src/Outgame/Map_Shop.tscn")
