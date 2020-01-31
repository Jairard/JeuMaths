extends Node2D

onready var treasure_damage	= 	preload("res://Src/Ingame/characters/gold.tscn")
onready var treasure_health	= 	preload("res://Src/Ingame/characters/gold.tscn")
onready var treasure_life	= 	preload("res://Src/Ingame/characters/gold.tscn")

func _ready():
	var treasureNode_damage = treasure_damage.instance()
	add_child(treasureNode_damage)

	var treasure_damage_pos_comp = ECS.add_component(treasureNode_damage, ComponentsLibrary.Position) as PositionComponent
	treasure_damage_pos_comp.set_position(Vector2(70,215))
	print ("treasure position : ", treasure_damage_pos_comp.get_position())
	
	var treasureNode_health = treasure_health.instance()
	add_child(treasureNode_health)

	var treasure_health_pos_comp = ECS.add_component(treasureNode_health, ComponentsLibrary.Position) as PositionComponent
	treasure_health_pos_comp.set_position(Vector2(440,215))
	print ("treasure position : ", treasure_health_pos_comp.get_position())
	
	var treasureNode_life = treasure_life.instance()
	add_child(treasureNode_life)

	var treasure_life_pos_comp = ECS.add_component(treasureNode_life, ComponentsLibrary.Position) as PositionComponent
	treasure_life_pos_comp.set_position(Vector2(795,215))
	print ("treasure position : ", treasure_life_pos_comp.get_position())
	
	

func _on_Damages_pressed():
	FileBankUtils.loaded_hero_stats["treasure"] -= 10
	FileBankUtils.loaded_hero_stats["damage"] += 10
	get_tree().change_scene("res://Src/Outgame/map_fire.tscn")


func _on_Health_pressed():
	FileBankUtils.loaded_hero_stats["treasure"] -= 10
	FileBankUtils.loaded_hero_stats["health"] += 10
#	FileBankUtils.save_json(FileBankUtils.loaded_hero_stats,"res://Assets/Stats_Characters/Hero_Stats.json")
	get_tree().change_scene("res://Src/Outgame/map_fire.tscn")

func _on_regen_health_pressed():
	FileBankUtils.loaded_hero_stats["treasure"] -= 20
	FileBankUtils.loaded_hero_stats["health"] += 10
	get_tree().change_scene("res://Src/Outgame/map_fire.tscn")

