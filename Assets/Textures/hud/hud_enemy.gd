extends Node2D

func get_life_enemy() -> TextureProgress:
	return $CanvasLayer/HBoxContainer/MarginContainer/life_ennemy	as TextureProgress

func get_life_enemy_label() -> Label:
	return $CanvasLayer/HBoxContainer3/MarginContainer/Label		as Label

func get_life_ennemy_max() -> TextureProgress:
	return $CanvasLayer/HBoxContainer/MarginContainer/life_ennemy	as TextureProgress

func get_damage() -> Label :
	return $CanvasLayer/HBoxContainer4/MarginContainer/damage 	as Label
