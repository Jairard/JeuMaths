extends Node

var health 			: int = 0
var health_max		: int = 0
var damage 			: int = 0
var treasure 		: int = 0
var good_answer 	: int = 0
var wrong_answer 	: int = 0
var victories	 	: int = 0
var defeats 		: int = 0
var scene_counter	: int = 0
var classroom		: int = 0
var pseudo			: String = ""
	
var loaded_scenes = load_json("res://Assets/Scenes.json")
var stats_File_Name : String = "res://Assets/Stats_Characters/Hero_Stats.json"
var loaded_heroes_stats = load_json(stats_File_Name)

func load_json(path : String):
	var file = File.new()
	file.open(path, File.READ)
	var text = file.get_as_text()
	var content = parse_json(text)
	file.close()
	return content

func save_json(dict,path : String) -> void:
	var file = File.new()
	file.open(path, File.WRITE)
	var streuh = to_json(dict)
	file.store_string(streuh)
	file.close()

func init_stats(stats : Dictionary, _pseudo : String) -> void:
	health 			= stats["health"]
	damage 			= stats["damage"]
	treasure		= stats["treasure"]
	good_answer 	= stats["good_answer"]
	wrong_answer 	= stats["wrong_answer"]
	victories	 	= stats["victories"]
	defeats			= stats["defeats"]
	health_max		= stats["health_max"]
	pseudo			= _pseudo
	scene_counter	= stats["scene_counter"]
	
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		var stats : Dictionary = {
									"damage":damage,"health":health,"treasure":treasure,
									"good_answer":good_answer,"wrong_answer":wrong_answer,
									"victories":victories, "defeats":defeats,
									"health_max":health_max, "scene_counter":scene_counter	  
								}
		if loaded_heroes_stats == null:
			loaded_heroes_stats = {}
		loaded_heroes_stats[pseudo] = stats
		save_json(loaded_heroes_stats, stats_File_Name)

func load_right_scene():
	if FileBankUtils.scene_counter % 4 == 1:
		return Scene_changer.change_scene(FileBankUtils.loaded_scenes["playing_map"][1]["map_fire"])
	elif FileBankUtils.scene_counter % 4 == 2: 	
		return Scene_changer.change_scene(FileBankUtils.loaded_scenes["map_water"])
	elif FileBankUtils.scene_counter % 4 == 3: 
		return Scene_changer.change_scene(FileBankUtils.loaded_scenes["playing_map"][2]["map_fire_0"])
	elif FileBankUtils.scene_counter % 4 == 4: 
		return Scene_changer.change_scene(FileBankUtils.loaded_scenes["upside_down"])
