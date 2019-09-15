extends Node2D

onready var hero  	= 	preload("res://characters/hero.tscn")
onready var enemy 	= 	preload("res://characters/Ennemy.tscn")
onready var answer 	= 	preload("res://characters/Answer.tscn")
onready var hud 	= 	preload("res://hud/hud_hero.tscn")


func _ready():
	
	ECS.register_system(SystemsLibrary.Move)
	ECS.register_system(SystemsLibrary.Input)
	ECS.register_system(SystemsLibrary.Animation)
	ECS.register_system(SystemsLibrary.Collision)
	ECS.register_system(SystemsLibrary.Hud)
	
	
	var enemyNode = enemy.instance()
	add_child(enemy.instance())
	enemyNode.set_name("enemy")
	
	var heroNode = hero.instance()
	add_child(heroNode)
	heroNode.set_name("hero")
	
	var HudNode = hud.instance()
	add_child(HudNode)
	HudNode.set_name("Hud")

	var answerNode = answer.instance()
	add_child(answerNode)
	answerNode.set_name("answer")
	
	

	ECS.add_component(heroNode, ComponentsLibrary.Movement)
	ECS.add_component(heroNode, ComponentsLibrary.Collision)
	var comp_anim_hero = ECS.add_component(heroNode, ComponentsLibrary.Animation) as AnimationComponent
	var anim_name_hero = {comp_anim_hero.anim.left : "anim_left", comp_anim_hero.anim.right : "anim_right", comp_anim_hero.anim.jump : "anim_jump", comp_anim_hero.anim.idle : "anim_idle"}
	var animation_player_hero = heroNode.get_node("animation_hero")
	comp_anim_hero.init(anim_name_hero, animation_player_hero)
	var hero_pos = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	hero_pos.set_position(Vector2(300,300))	
	
	
#	var enemy_pos = ECS.add_component(enemyNode, ComponentsLibrary.Position) as PositionComponent
#	enemy_pos.set_position(Vector2(400,300))
	
	
	var answer_pos = ECS.add_component(answerNode, ComponentsLibrary.Position) as PositionComponent
	answer_pos.set_position(Vector2(350,500))
	
	
	
