extends Node2D

onready var treasure = preload("res://Src/Ingame/characters/treasure.tscn")

func _ready():
	add_child(treasure.instance())

func get_life_hero() -> TextureProgress :
	return $CanvasLayer/pv_hero/MarginContainer/life_hero 			as TextureProgress
	
func get_life_hero_label() -> Label :
	return $CanvasLayer/HBoxContainer5/MarginContainer/health 		as Label		

func get_life_hero_max() -> TextureProgress  :	
	return $CanvasLayer/pv_hero/MarginContainer/life_hero 			as TextureProgress

func get_damage() -> Label :
	return $CanvasLayer/valeur_degats/MarginContainer/valeur_degat 	as Label
		
func get_xp() -> TextureProgress :
	return $CanvasLayer/HBoxContainer/MarginContainer/xp 			as TextureProgress
	
func get_level() -> Label :
	return $CanvasLayer/HBoxContainer2/MarginContainer/level 		as Label
		
func get_treasure() -> Label :
	return $CanvasLayer/HBoxContainer4/MarginContainer/treasure 	as Label
	


