extends Node2D

func _on_reset_button_pressed():
	Fade.change_scene(FileBankUtils.loaded_scenes["map_fight_1"])
