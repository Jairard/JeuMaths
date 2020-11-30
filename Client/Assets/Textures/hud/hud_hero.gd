extends Node2D

func get_life_hero() -> TextureProgress :
	return $CanvasLayer/life_hero 			as TextureProgress

func get_life_hero_label() -> Label :
	return $CanvasLayer/health 		as Label

func get_damage() -> Label :
	return $CanvasLayer/HBoxContainer/damages 	as Label


