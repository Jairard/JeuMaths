extends Node2D


func _ready():
	pass 


#func _process(delta):
#	pass

func _on_Button_pressed():
	get_tree().change_scene("res://map/create_hero.tscn")
	pass 


func _on_LineEdit_text_changed(new_text):
	save(new_text)
	
func save(new_text) :
	var dict = {"pseudo" : ""}
	var file = File.new()
	file.open("res://log_in/pseudo.json", File.READ)
	var text = parse_json(file.get_as_text())
	file.close()
	print (dict)

