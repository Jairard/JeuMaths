extends Node2D

func return_map() -> void:
	get_tree().change_scene("res://Src/Outgame/map_fire.tscn")

func _on_Damages_pressed():
	return_map()


func _on_Health_pressed():
	FileBankUtils.loaded_hero_stats["health"] += 10
	FileBankUtils.save_json(FileBankUtils.loaded_hero_stats,"res://Assets/Stats_Characters/Hero_Stats.json")
#	return_map()


func _on_Xp_pressed():
	return_map()