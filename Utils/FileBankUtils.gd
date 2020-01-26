extends Node

var health 			: int = 0
var damage 			: int = 0
var treasure 		: int = 0
var good_answer 	: int = 1
var wrong_answer 	: int = 1
var boss_killed 	: int = 1

var loaded_scenes = load_json("res://Assets/Scenes.json")
var loaded_hero_stats = load_json("res://Assets/Stats_Characters/Hero_Stats.json")

func load_json(path : String) -> Object:
	var file = File.new()
	file.open(path, File.READ)
	var text = file.get_as_text()
	var content = parse_json(text)
	file.close()
	return content
	
func save_json(dict : Object,path : String) -> void:
	var file = File.new()
	file.open(path, File.WRITE)
	var streuh = to_json(dict)
	file.store_string(streuh)
	file.close()

func init_stats(loaded_hero_stats) -> void:
	health 			= loaded_hero_stats["health"]
	damage 			= loaded_hero_stats["damage"]
	treasure		= loaded_hero_stats["treasure"]
	good_answer 	= loaded_hero_stats["good_answer"]
	wrong_answer 	= loaded_hero_stats["wrong_answer"]
	boss_killed 	= loaded_hero_stats["boss_killed"]