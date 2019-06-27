extends Node2D



func _ready():
	pass 
#func _process(delta):
#	pass



func _on_Button_pressed():
	get_tree().change_scene("res://map/map 0.tscn")
	pass

func _on_LineEdit_text_entered(new_text):
	pass # Replace with function body.
