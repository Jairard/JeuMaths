extends Node2D

func _on_Sign_In_pressed():
	Scene_changer.change_scene(FileBankUtils.loaded_scenes["sign_in"])

func _on_create_hero_pressed():
	Scene_changer.change_scene(FileBankUtils.loaded_scenes["create_hero"])


func _on_map_level_pressed():
	Scene_changer.change_scene(FileBankUtils.loaded_scenes["playing_map"][1]["map_fire"])

func _on_Map_fight_1_pressed():
	Scene_changer.change_scene(FileBankUtils.loaded_scenes["map_fight_1"])

func _on_Map_fight_2_pressed():
	Scene_changer.change_scene(FileBankUtils.loaded_scenes["map_fight_2"])


func _on_Shop_pressed():
	Scene_changer.change_scene(FileBankUtils.loaded_scenes["shop"])


func _on_Map_water_pressed():
	Scene_changer.change_scene(FileBankUtils.loaded_scenes["map_water"])
	

func _on_Rewards_pressed():
	Scene_changer.change_scene(FileBankUtils.loaded_scenes["rewards"])


func _on_Stats_pressed():
	Scene_changer.change_scene(FileBankUtils.loaded_scenes["stats"])


func _on_Death_pressed():
	Scene_changer.change_scene(FileBankUtils.loaded_scenes["death"])


func _on_Next_level_pressed():
	Scene_changer.change_scene(FileBankUtils.loaded_scenes["next_level"])



func _on_Map_tuto_pressed():
	Scene_changer.change_scene(FileBankUtils.loaded_scenes["playing_map"][0]["map_tuto"])
