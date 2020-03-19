extends Node2D

var stats : Dictionary = {}
const init_stats : Dictionary =  {
									"damage":15,"health":70,
									"treasure":0,"good_answer":0,
									"wrong_answer":0,"victories":0,"defeats":0,
									"health_max":70, "scene_counter":0
									} 
							

func _ready(): 
	if FileBankUtils.loaded_heroes_stats != null:
		stats = FileBankUtils.loaded_heroes_stats.duplicate(true)
	print ("scenes : ", FileBankUtils.loaded_scenes["playing_map"][0]["map_tuto"])
#func _process(delta):
#	pass

func get_stats(pseudo : String) -> Dictionary:
	for _pseudo in stats.keys():
		if _pseudo == pseudo:
			return { "new_hero" : false, "stats" : stats[_pseudo]}
	
	var new_stats = init_stats.duplicate(true)
	stats[pseudo] = new_stats
	return {"new_hero" : true, "stats" : new_stats}

func _on_Button_pressed():

	var pseudo : String = $TileMap/pseudo.get_text()
	var stats_hero = get_stats(pseudo)
	FileBankUtils.init_stats(stats_hero["stats"], pseudo)

	var anim = AnimationUtils.scene_fade_in(self)
	yield(anim, "animation_finished")

#	get_tree().change_scene(FileBankUtils.loaded_scenes["rewards"])
#	get_tree().change_scene(FileBankUtils.loaded_scenes["map_water"])
#	Scene_changer.change_scene(FileBankUtils.loaded_scenes["upside_down"])
#	get_tree().change_scene(FileBankUtils.loaded_scenes["playing_map"][0]["map_tuto"])
#	get_tree().change_scene(FileBankUtils.loaded_scenes["playing_map"][1]["map_fire"])
	get_tree().change_scene(FileBankUtils.loaded_scenes["playing_map"][2]["map_fire_0"])

#	if stats_hero["new_hero"] == true:
#		Scene_changer.change_scene(FileBankUtils.loaded_scenes["playing_map"][0]["map_tuto"])
#	else: 
#		if FileBankUtils.scene_counter % 4 == 1:
#			Scene_changer.change_scene(FileBankUtils.loaded_scenes["playing_map"][1]["map_fire"])
#		elif FileBankUtils.scene_counter % 4 == 2: 
#			Scene_changer.change_scene(FileBankUtils.loaded_scenes["map_water"])
#		elif FileBankUtils.scene_counter % 4 == 3: 
#			Scene_changer.change_scene(FileBankUtils.loaded_scenes["playing_map"][2]["map_fire_0"])
#		elif FileBankUtils.scene_counter % 4 == 4: 
#			Scene_changer.change_scene(FileBankUtils.loaded_scenes["upside_down"])


func _on_6eme_pressed():
	$_5eme/ColorRect.hide()
	$_5eme/question_5.hide()
	$_4eme/ColorRect.hide()
	$_4eme/questions_4.hide()
	$_3eme/ColorRect.hide()
	$_3eme/questions_3.hide()
	$_5eme.pressed = false
	$_4eme.pressed = false
	$_3eme.pressed = false
	FileBankUtils.classroom = 6
	$_6eme/ColorRect.show()
	$_6eme/questions_6.show()

func _on_5eme_pressed():
	$_6eme/ColorRect.hide()
	$_6eme/questions_6.hide()
	$_4eme/ColorRect.hide()
	$_4eme/questions_4.hide()
	$_3eme/ColorRect.hide()
	$_3eme/questions_3.hide()
	$_6eme.pressed = false
	$_4eme.pressed = false
	$_3eme.pressed = false
	FileBankUtils.classroom = 5
	$_5eme/ColorRect.show()
	$_5eme/question_5.show()



func _on_4eme_pressed():
	$_6eme/ColorRect.hide()
	$_6eme/questions_6.hide()
	$_5eme/ColorRect.hide()
	$_5eme/question_5.hide()
	$_3eme/ColorRect.hide()
	$_3eme/questions_3.hide()
	$_6eme.pressed = false
	$_5eme.pressed = false
	$_3eme.pressed = false
	FileBankUtils.classroom = 4
	$_4eme/ColorRect.show()
	$_4eme/questions_4.show()

func _on_3eme_pressed():
	$_6eme/ColorRect.hide()
	$_6eme/questions_6.hide()
	$_5eme/ColorRect.hide()
	$_5eme/question_5.hide()
	$_4eme/ColorRect.hide()
	$_4eme/questions_4.hide()
	$_6eme.pressed = false
	$_5eme.pressed = false
	$_4eme.pressed = false
	FileBankUtils.classroom = 3
	$_3eme/ColorRect.show()
	$_3eme/questions_3.show()
