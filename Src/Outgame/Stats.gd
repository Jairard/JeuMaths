extends Node2D

onready var hud 			= 	preload("res://Assets/Textures/hud/hud_hero.tscn")
onready var score			= 	preload("res://Assets/Textures/hud/hud_score.tscn")
onready var hero 			= 	preload("res://Src/Ingame/characters/hero.tscn")


func _ready():
	ECS.register_system(SystemsLibrary.Hud)
	var heroNode = hero.instance()
	heroNode.deactivate()
	add_child(heroNode)
	var hud_comp = ECS.add_component(heroNode, ComponentsLibrary.Hud) as HudComponent
	
	var HudNode = hud.instance()
	add_child(HudNode)
	
	var health_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Health, TagsLibrary.Tag_Hero) as HealthComponent
	health_comp_hero.init(FileBankUtils.health,FileBankUtils.health_max)


	var treasure_comp = ECS.add_component(heroNode, ComponentsLibrary.Treasure, TagsLibrary.Tag_Hero) as TreasureComponent
	treasure_comp.init(FileBankUtils.treasure)


	var damage_comp = ECS.add_component(heroNode, ComponentsLibrary.Damage, TagsLibrary.Tag_Hero) as DamageComponent
	damage_comp.init(FileBankUtils.damage)

	var score_comp = ECS.add_component(heroNode, ComponentsLibrary.Scoreglobal, TagsLibrary.Tag_Hero) as ScoreglobalcounterComponent
	score_comp.init(FileBankUtils.good_answer, FileBankUtils.wrong_answer, FileBankUtils.victories)

	var ScoreNode = score.instance()
	add_child(ScoreNode)
	hud_comp.init_hero_map(HudNode.get_life_hero(),HudNode.get_life_hero_label(),
	HudNode.get_life_hero_max(), HudNode.get_damage())

	hud_comp.init_hero_fight(ScoreNode.get_treasure(), ScoreNode.get_score())

	
	ECS.clear_ghosts()
	
	
	
	


func _on_return_pressed():
	Scene_changer.change_scene(FileBankUtils.loaded_scenes["playing_map"][1]["map_fire"])
