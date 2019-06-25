extends Node2D




func _ready():
	pass 


#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().change_scene("res://map/create_hero.tscn")
	pass 
