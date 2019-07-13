extends Node2D

func _ready():
	GLOBAL.connect("pv_ennemy", self, "set_pv_ennemy")
	

func set_pv_ennemy(value) :
	$CanvasLayer/HBoxContainer/MarginContainer/life_ennemy.value = value
	$CanvasLayer/HBoxContainer3/MarginContainer/Label.text = str(value)
	
func set_pv_ennemy_max(value) :
	$CanvasLayer/HBoxContainer/MarginContainer/life_ennemy.max_value = value
	$CanvasLayer/HBoxContainer/MarginContainer/life_ennemy.value = value
	$CanvasLayer/HBoxContainer3/MarginContainer/Label.text = str(value)