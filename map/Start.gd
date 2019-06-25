extends Node2D



func _ready():
	pass 


#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().change_scene("res://map/signin.tscn")
	print("sign") 



func _on_Buttonlogin_pressed():
	get_tree().change_scene("res://map/login.tscn")
	print("log")

