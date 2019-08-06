extends Node2D


func _ready():
	GLOBAL.connect("xp", self, "set_xp")
#	GLOBAL.connect("treasure", self, "set_xp")
	GLOBAL.connect("level", self, "set_level")
	GLOBAL.connect("pv_hero", self, "set_pv_hero")
	GLOBAL.connect("pv_hero_max", self, "set_pv_hero_max")
	GLOBAL.connect("degats", self, "set_degats")

	
func set_pv_hero(value) :		
	$CanvasLayer/pv_hero/MarginContainer/life_hero.value = value
	$CanvasLayer/HBoxContainer4/MarginContainer/Label.text = str(value)
	
func set_pv_hero_max(value) :	
	$CanvasLayer/pv_hero/MarginContainer/life_hero.max_value = value

func set_degats(value) :
	$CanvasLayer/valeur_degats/MarginContainer/valeur_degat.text = str(value)
		
func set_xp(value) :
	$CanvasLayer/HBoxContainer/MarginContainer/xp.value = value
	
func set_level(value) :
	$CanvasLayer/HBoxContainer2/MarginContainer/level.text = str(value)
		
	
