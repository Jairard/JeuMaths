extends Node2D

onready var hero   			= preload("res://characters/hero.tscn")
onready var enemy 			= preload("res://characters/Ennemy.tscn")
onready var hud_hero    	= preload("res://hud/hud_hero.tscn")
onready var hud_enemy    	= preload("res://hud/hud_enemy.tscn")
onready var calcul 			= preload("res://fight/calcul.tscn")
onready var spell_hero		= preload("res://fight/spell_hero.tscn")
onready var ulti_hero		= preload("res://fight/ulti_hero.tscn")
onready var spell_enemy		= preload("res://fight/spell_enemy.tscn")

onready var time_label = get_node("sol/time_label")
onready var game_timer = get_node("game_timer")

onready var heroNode = hero.instance()
onready var enemyNode = enemy.instance()

var answer_listener = []

func _ready():
	
	ECS.register_system(SystemsLibrary.Move)
	ECS.register_system(SystemsLibrary.Input)
	ECS.register_system(SystemsLibrary.Animation)
	ECS.register_system(SystemsLibrary.Hud)
	ECS.register_system(SystemsLibrary.Answer)
	ECS.register_system(SystemsLibrary.EmitPArticules)
	ECS.register_system(SystemsLibrary.Missile)
	ECS.register_system(SystemsLibrary.Collision)
	
	spawn()
	
	answer_listener.append(ECS.add_component(enemyNode, ComponentsLibrary.AnswerListener))
	answer_listener.append(ECS.add_component(enemyNode, ComponentsLibrary.EmitPArticules))
	ECS.add_component(enemyNode, ComponentsLibrary.Position)
	var answerToSpell_enemy = ECS.add_component(enemyNode, ComponentsLibrary.AnswertoSpell) as AnswertoSpellComponent
	answerToSpell_enemy.init({AnswerListenerComponent.answer.false : 
																	{AnswertoSpellComponent.property.name :"spell_enemy",
																	 AnswertoSpellComponent.property.target : heroNode}
																	})
	var comp_spell_enemy = ECS.add_component(enemyNode, ComponentsLibrary.Spell) as SpellComponent
	comp_spell_enemy.init({"spell_enemy" : spell_enemy})
	var health_comp_enemy = ECS.add_component(enemyNode, ComponentsLibrary.Health) as HealthComponent
	health_comp_enemy.init(50,50)
	ECS.add_component(enemyNode, ComponentsLibrary.Collision)
	ECS.add_component(enemyNode, ComponentsLibrary.Damage)
	
	
	var comp_spell_hero = ECS.add_component(heroNode, ComponentsLibrary.Spell) as SpellComponent
	comp_spell_hero.init({"spell_hero" : spell_hero, "ulti_hero" : ulti_hero})						#spellname --> scene instance
	answer_listener.append(ECS.add_component(heroNode, ComponentsLibrary.AnswerListener))
	answer_listener.append(ECS.add_component(heroNode, ComponentsLibrary.EmitPArticules))
	var answerToSpell_hero = ECS.add_component(heroNode, ComponentsLibrary.AnswertoSpell) as AnswertoSpellComponent
	answerToSpell_hero.init({AnswerListenerComponent.answer.true : 
																	{AnswertoSpellComponent.property.name :"spell_hero",
																	 AnswertoSpellComponent.property.target : enemyNode}
																	})
	ECS.add_component(heroNode, ComponentsLibrary.InputListener)
	ECS.add_component(heroNode, ComponentsLibrary.Movement)
	ECS.add_component(heroNode, ComponentsLibrary.Velocity)
	var comp_anim_hero = ECS.add_component(heroNode, ComponentsLibrary.Animation) as AnimationComponent
	var anim_name_hero = {comp_anim_hero.anim.left : "anim_left", comp_anim_hero.anim.right : "anim_right", comp_anim_hero.anim.jump : "anim_jump", comp_anim_hero.anim.idle : "anim_idle"}
	var animation_player_hero = heroNode.get_node("animation_hero")
	comp_anim_hero.init(anim_name_hero, animation_player_hero)
	var hero_pos = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	hero_pos.set_position(Vector2(100,500))	
	var health_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Health) as HealthComponent
	health_comp_hero.init(100,100)
	ECS.add_component(heroNode, ComponentsLibrary.Collision)
	ECS.add_component(heroNode, ComponentsLibrary.Xp)
	ECS.add_component(heroNode, ComponentsLibrary.Treasure)
	ECS.add_component(heroNode, ComponentsLibrary.Damage)

	load_hud()
	
func _process(delta):
	time_label.set_text(str(int(game_timer.get_time_left())))
		


func spawn() :
		
	add_child(heroNode)
	add_child(enemyNode)
	enemyNode.set_position(Vector2(750,350))	
	var sprite = $Ennemy/Sprite 
	sprite.apply_scale(Vector2(4, 4)) 
	$Ennemy/CollisionShape2D.scale = Vector2(4, 4)
	
func load_hud():
	var Hud_heroNode = hud_hero.instance()
	add_child(Hud_heroNode)
	Hud_heroNode.set_name("Hud_hero")
	
	var hud_hero_comp = ECS.add_component(Hud_heroNode, ComponentsLibrary.Hud) as HudComponent
	hud_hero_comp.init_hero(Hud_heroNode.get_life_hero(),Hud_heroNode.get_life_hero_label(), 
	Hud_heroNode.get_life_hero_max(), Hud_heroNode.get_damage(), 
	Hud_heroNode.get_xp(), Hud_heroNode.get_level(), Hud_heroNode.get_treasure())
	
	var Hud_enemyNode = hud_enemy.instance()
	add_child(Hud_enemyNode)
	Hud_enemyNode.set_name("Hud_enemy")
	

func _on_game_timer_timeout():

	time_label.hide()
	var calcul_instance = calcul.instance()
	calcul_instance.set_answer_listener(answer_listener)
	add_child(calcul_instance)
	

	

