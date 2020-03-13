extends Node2D

func get_life_hero() -> TextureProgress :
	return $CanvasLayer/pv_hero/MarginContainer/life_hero 			as TextureProgress

func get_life_hero_label() -> Label :
	return $CanvasLayer/HBoxContainer5/MarginContainer/health 		as Label

func get_life_hero_max() -> TextureProgress  :
	return $CanvasLayer/pv_hero/MarginContainer/life_hero 			as TextureProgress

func get_damage() -> Label :
	return $CanvasLayer/valeur_degats/MarginContainer/valeur_degat 	as Label

func get_tween() -> Tween:
	return $CanvasLayer/HBoxContainer5/Tween as Tween


