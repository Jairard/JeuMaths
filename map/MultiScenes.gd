extends Node2D

func _ready():
	pass 
	
func _on_Start_pressed():
	get_tree().change_scene("res://map/Start.tscn")
	
func _on_Sign_In_pressed():
	get_tree().change_scene("res://map/Signin.tscn")
	
func _on_create_hero_pressed():
	get_tree().change_scene("res://map/create_hero.tscn")

func _on_Log_In_pressed():
	get_tree().change_scene("res://map/Login.tscn")

func _on_map_level_pressed():
	get_tree().change_scene("res://map/map_level.tscn")
	
func _on_Map_fight_1_pressed():
	get_tree().change_scene("res://map/map_fight_1.tscn")

func _on_Map_fight_2_pressed():
	get_tree().change_scene("res://map/map_fight_2.tscn")


func _on_Shop_pressed():
	get_tree().change_scene("res://map/Map_Shop.tscn")
