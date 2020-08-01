extends Control



func _on_TextureButton_pressed():
	Fade.change_scene(FileBankUtils.loaded_scenes["tuto_fight"])


func _on_Button_pressed():
	Fade.change_scene(FileBankUtils.loaded_scenes["sign_in"])
