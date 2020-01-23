extends Node2D

onready var hero 			= 	preload("res://Src/Ingame/characters/hero.tscn")
onready var hud 			= 	preload("res://Assets/Textures/hud/hud_hero.tscn")
onready var score			= 	preload("res://Assets/Textures/hud/hud_score.tscn")

func _ready():
	var heroNode = hero.instance()
	add_child(heroNode)
	heroNode.set_name("hero")
	var hero_pos = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	hero_pos.set_position(Vector2(200,500))	
	
	
	var HudNode = hud.instance()
	add_child(HudNode)

	var ScoreNode = score.instance()
	add_child(ScoreNode)
	ScoreNode.set_name("Score")
	
	var hud_comp = ECS.add_component(heroNode, ComponentsLibrary.Hud) as HudComponent
	
	hud_comp.init_hero(HudNode.get_life_hero(),HudNode.get_life_hero_label(), 
	HudNode.get_life_hero_max(), HudNode.get_damage(), 
	HudNode.get_xp(), HudNode.get_level(), HudNode.get_treasure(), ScoreNode.get_score())	

func _on_Button_pressed():
	get_tree().change_scene("res://Src/Outgame/Multiscenes.tscn")
