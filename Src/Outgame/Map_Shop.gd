extends Node2D

func _on_Damages_pressed():
	FileBankUtils.loaded_hero_stats["damage"] += 10
	get_tree().change_scene("res://Src/Outgame/map_fire.tscn")


func _on_Health_pressed():
	FileBankUtils.loaded_hero_stats["health"] += 10
#	FileBankUtils.save_json(FileBankUtils.loaded_hero_stats,"res://Assets/Stats_Characters/Hero_Stats.json")
	get_tree().change_scene("res://Src/Outgame/map_fire.tscn")

func _on_regen_health_pressed():
	get_tree().change_scene("res://Src/Outgame/map_fire.tscn")

