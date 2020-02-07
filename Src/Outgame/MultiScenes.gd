extends Node2D

func _ready():
	pass

func _on_Start_pressed():
	get_tree().change_scene("res://Src/Outgame/Start.tscn")

func _on_Sign_In_pressed():
	get_tree().change_scene("res://Src/Outgame/Signin.tscn")

func _on_create_hero_pressed():
	get_tree().change_scene("res://Src/Outgame/create_hero.tscn")

func _on_Log_In_pressed():
	get_tree().change_scene("res://Src/Outgame/Login.tscn")

func _on_map_level_pressed():
	get_tree().change_scene("res://Src/Outgame/map_fire.tscn")

func _on_Map_fight_1_pressed():
	get_tree().change_scene("res://Src/Outgame/map_fight_1.tscn")

func _on_Map_fight_2_pressed():
	get_tree().change_scene("res://Src/Outgame/map_fight_2.tscn")


func _on_Shop_pressed():
	get_tree().change_scene("res://Src/Outgame/Map_Shop.tscn")


func _on_Map_water_pressed():
	get_tree().change_scene("res://Src/Outgame/Map_Water.tscn")



func _on_Rewards_pressed():
	get_tree().change_scene("res://Src/Outgame/Rewards.tscn")
