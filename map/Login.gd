extends Node2D

func _ready():
	pass 
#func _process(delta):
#	pass



func _on_Button_pressed():
	get_tree().change_scene("res://map/map_level.tscn")
	pass

func _on_LineEdit_text_entered(new_text):
	_load()

func _load() :
	var dict = {"pseudo" : ""}
	var file = File.new()
	file.open("res://log_in/pseudo.json", File.READ)
	var new_text = parse_json(file.get_as_text())
	file.close()
	print (dict)
	dict["pseudo"] = new_text
	if dict["pseudo"] != "" :
		print ("connu")
	else :
		print ("s'inscrire")

