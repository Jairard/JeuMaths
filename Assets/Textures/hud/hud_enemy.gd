extends Node2D

func get_life_enemy() -> TextureProgress:
	return $CanvasLayer/life_ennemy	as TextureProgress

func get_life_enemy_label() -> Label:
	return $CanvasLayer/health		as Label

func get_damage() -> Label:
	return $damage as Label
