extends Node2D

func return_map() -> void:
	get_tree().change_scene("res://Src/Outgame/map_level.tscn")

func _on_Damages_pressed():
	return_map()


func _on_Health_pressed():
	return_map()


func _on_Xp_pressed():
	return_map()
