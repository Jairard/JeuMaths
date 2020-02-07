extends Node2D

enum type_class {Tank, Assassin, Mage}
export (type_class) var class_type


func _ready():
	pass


#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().change_scene("res://Src/Outgame/map_fire.tscn")



func _on_Tank_pressed():
	class_type == type_class.Tank
	print("Tank")
#		hero = Tank
	pass


func _on_Assassin_pressed():
	class_type == type_class.Assassin
	print("Assassin")
	pass


func _on_Mage_pressed():
	class_type == type_class.Mage
	print("Mage")
	pass
