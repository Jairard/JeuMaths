extends Node2D



func _on_next_level_pressed():
#	get_tree().change_scene(FileBankUtils.loaded_scenes["playing_map"]["map_fire"])
	get_tree().change_scene("res://Src/Outgame/map_fire.tscn")

func _on_shop_pressed():
#	get_tree().change_scene(FileBankUtils.loaded_scenes["shop"])
	get_tree().change_scene("res://Src/Outgame/Map_Shop.tscn")
	
