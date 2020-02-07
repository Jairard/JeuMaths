extends Node

var health 			: int = 0
var health_max		: int = 0
var damage 			: int = 0
var treasure 		: int = 0
var good_answer 	: int = 0
var wrong_answer 	: int = 0
var boss_killed 	: int = 0
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
	boss_killed 	= stats["boss_killed"]
	health_max		= stats["health_max"]
	pseudo			= _pseudo
	
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		print ("health_max : ", health_max)
		print ("health : ", health)
		print ("damage : ", damage)
		var stats : Dictionary = {
									"damage":damage,"health":health,
									"treasure":treasure,"good_answer":good_answer,
									"wrong_answer":wrong_answer,"boss_killed":boss_killed,
									"health_max":health_max	  
								}
		if loaded_heroes_stats == null:
			loaded_heroes_stats = {}
		loaded_heroes_stats[pseudo] = stats
		save_json(loaded_heroes_stats, stats_File_Name)
		
		
		
