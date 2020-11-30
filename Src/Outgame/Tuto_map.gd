extends Control


func _on_TextureButton_pressed():
	Fade.change_scene(FileBankUtils.load_right_scene())


func _on_CheckBox_pressed():
	if FileBankUtils.hide_tuto:
		FileBankUtils.hide_tuto = false
	else:
		FileBankUtils.hide_tuto = true
