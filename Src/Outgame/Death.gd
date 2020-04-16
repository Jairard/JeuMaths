extends Node2D

func _ready():
	pass

func _on_reset_button_pressed():
	Fade.change_scene(FileBankUtils.loaded_scenes["playing_map"][1]["map_fire"])
