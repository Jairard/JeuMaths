extends Node

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