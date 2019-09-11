extends Node2D

onready var gold = preload("res://characters/Gold.tscn")

func _ready():
#	add_child(gold.instance())
#	GLOBAL.connect("xp", self, "set_xp")
#	GLOBAL.connect("treasure", self, "set_treasure")
#	GLOBAL.connect("level", self, "set_level")
#	GLOBAL.connect("pv_hero", self, "set_pv_hero")
#	GLOBAL.connect("pv_hero_max", self, "set_pv_hero_max")
#	GLOBAL.connect("degats", self, "set_degats")
	pass

func get_life_hero() -> TextureProgress :
	return $CanvasLayer/pv_hero/MarginContainer/life_hero 			as TextureProgress
	
func get_life_hero_label() -> Label :
		return $CanvasLayer/HBoxContainer4/MarginContainer/Label 	as Label		

func get_life_hero_max() -> TextureProgress  :	
	return $CanvasLayer/pv_hero/MarginContainer/life_hero 			as TextureProgress

func get_damage() -> Label :
	return $CanvasLayer/valeur_degats/MarginContainer/valeur_degat 	as Label
		
func get_xp() -> TextureProgress :
	return $CanvasLayer/HBoxContainer/MarginContainer/xp 			as TextureProgress
	
func get_level() -> Label :
	return $CanvasLayer/HBoxContainer2/MarginContainer/level 		as Label
		
func get_treasure() -> Label :
	return $CanvasLayer/HBoxContainer6/MarginContainer/Label 		as Label
