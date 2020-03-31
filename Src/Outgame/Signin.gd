extends Node2D

onready var rect = $Control/ColorRect

var stats : Dictionary = {}
const init_stats : Dictionary =  {
									"damage":15, "health":70,
									"treasure":0,"good_answer":0,
									"wrong_answer":0,"victories":0,"defeats":0,
									"health_max":70, "scene_counter":0
									} 	

func _ready(): 

#	var anim = AnimationUtils.canvas_fade_in(self)
#	yield(anim, "animation_finished")
	var anim_rect = AnimationUtils.rect_fade_in(self)
	yield(anim_rect, "animation_finished")
	rect.hide()
	
	if FileBankUtils.loaded_heroes_stats != null:
		stats = FileBankUtils.loaded_heroes_stats.duplicate(true)

	add_map_option_()
	add_fight_option()
	add_featured_option()
	add_unused_option()
	
	

func add_map_option_() -> void:
	$Control_Option/Option_map.set_text("Maps")	
	$Control_Option/Option_map.add_separator()
	$Control_Option/Option_map.add_item("tuto")
	$Control_Option/Option_map.add_item("fire")
	$Control_Option/Option_map.add_item("water")
	$Control_Option/Option_map.add_item("fire_0")
	$Control_Option/Option_map.add_item("water_0")
	$Control_Option/Option_map.add_item("upside_down")
	
func add_fight_option() -> void:
	$Control_Option/Option_fight.set_text("Fights")
	$Control_Option/Option_fight.add_separator()
	$Control_Option/Option_fight.add_item("fight_1")
	$Control_Option/Option_fight.add_item("fight_2")	

func add_featured_option() -> void:
	$Control_Option/Option_featured_scenes.set_text("Featured")
	$Control_Option/Option_featured_scenes.add_separator()
	$Control_Option/Option_featured_scenes.add_item("rewards")	
	$Control_Option/Option_featured_scenes.add_item("shop")
	$Control_Option/Option_featured_scenes.add_item("death")
	
func add_unused_option() -> void:
	$Control_Option/Option_unused_scenes.set_text("Unused")
	$Control_Option/Option_unused_scenes.add_separator()
	$Control_Option/Option_unused_scenes.add_item("create_hero")	


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
	rect.show()
	var anim_rect = AnimationUtils.rect_fade_out(self)
	yield(anim_rect, "animation_finished")
#	var anim = AnimationUtils.canvas_fade_out(self)
#	yield(anim, "animation_finished")
	$Control_Option.hide()
	
	
	match id:
		1:
			get_tree().change_scene(FileBankUtils.loaded_scenes["playing_map"][0]["map_tuto"])
		2:
			get_tree().change_scene(FileBankUtils.loaded_scenes["playing_map"][1]["map_fire"])
		3:
			get_tree().change_scene(FileBankUtils.loaded_scenes["map_water"])
		4:
			get_tree().change_scene(FileBankUtils.loaded_scenes["playing_map"][2]["map_fire_0"])
		5:
			get_tree().change_scene(FileBankUtils.loaded_scenes["map_water_0"])
		6:
			get_tree().change_scene(FileBankUtils.loaded_scenes["upside_down"])

func _on_Option_fight_item_selected(id):
	load_stats()
	
	match id:
		1:
			get_tree().change_scene(FileBankUtils.loaded_scenes["map_fight_1"])
		2:
			get_tree().change_scene(FileBankUtils.loaded_scenes["map_fight_2"])

func _on_Option_featured_scenes_item_selected(id):
	load_stats()	
	match id:
		1:
			get_tree().change_scene(FileBankUtils.loaded_scenes["rewards"])
		2:
			get_tree().change_scene(FileBankUtils.loaded_scenes["shop"])
		3:
			get_tree().change_scene(FileBankUtils.loaded_scenes["death"])

func _on_Option_unused_scenes_item_selected(id):
	load_stats()	
	match id:
		1:
			get_tree().change_scene(FileBankUtils.loaded_scenes["create_hero"])
