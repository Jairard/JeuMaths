extends Node2D

var stats : Dictionary = {}
const init_stats : Dictionary =  {
									"damage":15,"health":70,
									"treasure":0,"good_answer":0,
									"wrong_answer":0,"victories":0,"defeats":0,
									"health_max":70, "scene_counter":0
									} 	

func _ready(): 

	var anim = AnimationUtils.canvas_fade_in(self)
	yield(anim, "animation_finished")
	var anim_rect = AnimationUtils.rect_fade_in(self)
	yield(anim_rect, "animation_finished")

	
	if FileBankUtils.loaded_heroes_stats != null:
		stats = FileBankUtils.loaded_heroes_stats.duplicate(true)

	add_map_option_()
	add_fight_option()
	add_featured_option()
	add_unused_option()
	
	

func add_map_option_() -> void:
	$Option_map.set_text("Maps")	
	$Option_map.add_separator()
	$Option_map.add_item("tuto")
	$Option_map.add_item("fire")
	$Option_map.add_item("water")
	$Option_map.add_item("fire_0")
	$Option_map.add_item("water_0")
	$Option_map.add_item("upside_down")
	
func add_fight_option() -> void:
	$Option_fight.set_text("Fights")
	$Option_fight.add_separator()
	$Option_fight.add_item("fight_1")
	$Option_fight.add_item("fight_2")	

func add_featured_option() -> void:
	$Option_featured_scenes.set_text("Featured")
	$Option_featured_scenes.add_separator()
	$Option_featured_scenes.add_item("rewards")	
	$Option_featured_scenes.add_item("shop")
	$Option_featured_scenes.add_item("death")
	
func add_unused_option() -> void:
	$Option_unused_scenes.set_text("Unused")
	$Option_unused_scenes.add_separator()
	$Option_unused_scenes.add_item("create_hero")	


func get_stats(pseudo : String) -> Dictionary:
	for _pseudo in stats.keys():
		if _pseudo == pseudo:
			return { "new_hero" : false, "stats" : stats[_pseudo]}
	
	var new_stats = init_stats.duplicate(true)
	stats[pseudo] = new_stats
	return {"new_hero" : true, "stats" : new_stats}


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


func load_stats():
	var pseudo : String = $TileMap/pseudo.get_text()
	var stats_hero = get_stats(pseudo)
	FileBankUtils.init_stats(stats_hero["stats"], pseudo)
	
	

func _on_Option_map_item_selected(id):
	load_stats()
	
	var anim_rect = AnimationUtils.rect_fade_out(self)
	yield(anim_rect, "animation_finished")
	var anim = AnimationUtils.canvas_fade_out(self)
	yield(anim, "animation_finished")
	
	
	match id:
		1:
			get_tree().change_scene(FileBankUtils.loaded_scenes["playing_map"][0]["map_tuto"])
		2:
			FileBankUtils.loaded_scenes["playing_map"][1]["map_fire"]
		3:
			FileBankUtils.loaded_scenes["map_water"]
		4:
			FileBankUtils.loaded_scenes["playing_map"][2]["map_fire_0"]
		5:
			FileBankUtils.loaded_scenes["map_water_0"]
		6:
			FileBankUtils.loaded_scenes["upside_down"]

func _on_Option_fight_item_selected(id):
	load_stats()
	
	match id:
		1:
			FileBankUtils.loaded_scenes["map_fight_1"]
		2:
			FileBankUtils.loaded_scenes["map_fight_2"]

func _on_Option_featured_scenes_item_selected(id):
	load_stats()	
	match id:
		1:
			FileBankUtils.loaded_scenes["rewards"]
		2:
			FileBankUtils.loaded_scenes["shop"]
		3:
			FileBankUtils.loaded_scenes["death"]

func _on_Option_unused_scenes_item_selected(id):
	load_stats()	
	match id:
		1:
			FileBankUtils.loaded_scenes["create_hero"]
