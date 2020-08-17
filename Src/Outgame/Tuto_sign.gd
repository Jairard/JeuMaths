extends Control

func _ready():
	if FileBankUtils.hide_tuto:
		FileBankUtils.loaded_scenes["sign_in"]
		pass
func _on_TextureButton_pressed():
	Fade.change_scene(FileBankUtils.loaded_scenes["sign_in"])

