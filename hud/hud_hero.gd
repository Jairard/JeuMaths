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
	return $CanvasLayer/pv_hero/MarginContainer/life_hero as TextureProgress
	
func get_life_hero_label() -> Label :
	return $CanvasLayer/HBoxContainer4/MarginContainer/Label as Label	
	
	
func set_pv_hero_max(value) :	
	$CanvasLayer/pv_hero/MarginContainer/life_hero.max_value = value

func set_degats(value) :
	$CanvasLayer/valeur_degats/MarginContainer/valeur_degat.text = str(value)
		
func set_xp(value) :
	$CanvasLayer/HBoxContainer/MarginContainer/xp.value = value
	
func set_level(value) :
	$CanvasLayer/HBoxContainer2/MarginContainer/level.text = str(value)
		
func set_treasure(value) :
	$CanvasLayer/HBoxContainer6/MarginContainer/Label.text = str(value)
