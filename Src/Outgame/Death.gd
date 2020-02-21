extends Node2D



func _on_reset_button_pressed():
	get_tree().change_scene(FileBankUtils.loaded_scenes["playing_map"][1]["map_fire"])
