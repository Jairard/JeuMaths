extends Node2D



func _on_next_level_pressed():
	get_tree().change_scene(FileBankUtils.loaded_scenes["playing_map"][1]["map_fire"])

func _on_shop_pressed():
	get_tree().change_scene(FileBankUtils.loaded_scenes["shop"])

	
