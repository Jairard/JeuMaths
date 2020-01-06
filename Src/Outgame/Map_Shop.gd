extends Node2D

var file = File.new()
var dict : Dictionary = {}

func load_c(path : String) -> Dictionary:
	file.open(path, File.READ)
	var text = file.get_as_text()
	dict = parse_json(text)
	file.close()
	return dict

func save_ressources():
	print (dict)
	file.open("res://Assets/Stats_Characters/Hero_Stats.json", File.WRITE)
	var dict = to_json(dict)
	print ("dict : ", dict)
	file.store_string(dict)
	file.close()
	print (dict)

func return_map() -> void:
	get_tree().change_scene("res://Src/Outgame/map_fire.tscn")

func _on_Damages_pressed():
	return_map()


func _on_Health_pressed():
	load_c("res://Assets/Stats_Characters/Hero_Stats.json")
	dict["health"] += 10
	save_ressources()
#	return_map()


func _on_Xp_pressed():
	return_map()