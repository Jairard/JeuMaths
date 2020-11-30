extends Control


func _on_TextureButton_pressed():
	Fade.change_scene(FileBankUtils.loaded_scenes["map_fight_1"])
