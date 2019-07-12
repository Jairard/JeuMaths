extends Node2D

func _ready():
	GLOBAL.connect("pv_ennemy", self, "set_pv_ennemy")


func set_pv_ennemy(value) :
	$CanvasLayer/HBoxContainer/MarginContainer/life_ennemy.value = value