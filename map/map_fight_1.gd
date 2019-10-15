extends Node2D

onready var hero   		= preload("res://characters/hero.tscn")
onready var enemy 		= preload("res://characters/Ennemy.tscn")
onready var hud    		= preload("res://hud/hud_hero.tscn")
onready var hud_pro    	= preload("res://hud/hud_enemy.tscn")
onready var spell 		= preload("res://fight/test_spell.tscn")
onready var spell_enemy = preload("res://fight/spell_enemy.tscn")
onready var calcul 		= preload("res://fight/calcul.tscn")

onready var time_label = get_node("sol/time_label")
onready var game_timer = get_node("game_timer")

onready var heroNode = hero.instance()
onready var enemyNode = enemy.instance()

func _ready():
	
	ECS.register_system(SystemsLibrary.Move)
	ECS.register_system(SystemsLibrary.Input)
	ECS.register_system(SystemsLibrary.Animation)
	ECS.register_system(SystemsLibrary.Hud)
	
	spawn()

	ECS.add_component(heroNode, ComponentsLibrary.InputListener)
	ECS.add_component(heroNode, ComponentsLibrary.Movement)
	ECS.add_component(heroNode, ComponentsLibrary.Velocity)
	var comp_anim_hero = ECS.add_component(heroNode, ComponentsLibrary.Animation) as AnimationComponent
	var anim_name_hero = {comp_anim_hero.anim.left : "anim_left", comp_anim_hero.anim.right : "anim_right", comp_anim_hero.anim.jump : "anim_jump", comp_anim_hero.anim.idle : "anim_idle"}
	var animation_player_hero = heroNode.get_node("animation_hero")
	comp_anim_hero.init(anim_name_hero, animation_player_hero)
	var hero_pos = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	hero_pos.set_position(Vector2(100,500))	
	
func _process(delta):
	time_label.set_text(str(int(game_timer.get_time_left())))
		


func spawn() :
		
	add_child(heroNode)
	add_child(enemyNode)
	
	enemyNode.set_position(Vector2(750,350))	
	var sprite = $Ennemy/Sprite 
	sprite.apply_scale(Vector2(4, 4)) 
	$Ennemy/CollisionShape2D.scale = Vector2(4, 4)
	

func _on_game_timer_timeout():

	time_label.hide()
	add_child(calcul.instance())


	


