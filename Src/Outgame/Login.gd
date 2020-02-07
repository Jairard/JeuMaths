extends Node2D

var dict = {}
var file = File.new()

func _ready():
	_load()

#func _process(delta):
#	pass

func _on_Button_pressed():
	verif_pseudo()


func _load() :

	file.open("res://log_in/pseudo.json", File.READ)
	dict = parse_json(file.get_as_text())
	file.close()

func verif_pseudo():
	if dict["pseudo"] == $TileMap/LineEdit.get_text():
		get_tree().change_scene("res://Src/Outgame/map_fire.tscn")
	else :
		get_tree().change_scene("res://Src/Outgame/Signin.tscn")


