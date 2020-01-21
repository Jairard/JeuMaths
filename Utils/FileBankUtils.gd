extends Node

var health 	: int = 0
var xp 		: int = 0
var level = 0
var damage 	: int = 0
var treasure : int = 0

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
	health 	= loaded_hero_stats["health"]
	damage 	= loaded_hero_stats["damage"]
	xp 		= loaded_hero_stats["xp"]
	level 	= loaded_hero_stats["level"]
	treasure= loaded_hero_stats["treasure"]