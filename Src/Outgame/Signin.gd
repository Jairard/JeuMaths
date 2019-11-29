extends Node2D

var dict = {}
var file = File.new()

func _ready():
	_load()

#func _process(delta):
#	pass

func _on_Button_pressed():
	
	dict["pseudo"] = $TileMap/pseudo.get_text()
	save()
	get_tree().change_scene("res://Src/Outgame/create_hero.tscn")

func _load():
	
	file.open("res://log_in/pseudo.json", File.READ)
	dict = parse_json(file.get_as_text())
	file.close()
		
func save():
	
	file.open("res://log_in/pseudo.json", File.WRITE)
	var text = to_json(dict)
	file.store_string(text)
	file.close()