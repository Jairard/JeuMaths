extends Node2D

onready var girl_white 			= 	preload("res://Src/Ingame/characters/Girl_white.tscn")
onready var girl_black 			= 	preload("res://Src/Ingame/characters/Girl_black.tscn")
onready var boy_white 			= 	preload("res://Src/Ingame/characters/Boy_white.tscn")
onready var zombie 				= 	preload("res://Src/Ingame/characters/Zombie.tscn")
onready var punk 				= 	preload("res://Src/Ingame/characters/Punk.tscn")
onready var robot 				= 	preload("res://Src/Ingame/characters/Robot.tscn")
onready var enemy 			= preload("res://Src/Ingame/characters/Ennemy.tscn")
onready var hud_hero    	= preload("res://Assets/Textures/hud/hud_hero.tscn")
onready var hud_enemy    	= preload("res://Assets/Textures/hud/hud_enemy.tscn")
onready var calcul 			= preload("res://Src/Ingame/Animation/calcul.tscn")
onready var spell_hero		= preload("res://Src/Ingame/Animation/spell_hero.tscn")
onready var ulti_hero		= preload("res://Src/Ingame/Animation/ulti_hero.tscn")
onready var spell_enemy		= preload("res://Src/Ingame/Animation/spell_enemy.tscn")

onready var score			= 	preload("res://Assets/Textures/hud/hud_score.tscn")

onready var time_label = get_node("time_label")
onready var game_timer = get_node("game_timer")

onready var heroNode = punk.instance()
onready var enemyNode = enemy.instance()
var listener_hero : Component = null
var listener_enemy : Component = null
var treasure_comp : Component = null
var answerToSpell_hero : Component = null
var damage_comp_hero : Component = null
var health_comp_hero : Component = null

var answer_listener : Array = []

func _ready():

	ECS.register_system(SystemsLibrary.Move)
	ECS.register_system(SystemsLibrary.Input)
	ECS.register_system(SystemsLibrary.Animation)
	ECS.register_system(SystemsLibrary.Hud)
	ECS.register_system(SystemsLibrary.Answer)
	ECS.register_system(SystemsLibrary.EmitPArticules)
	ECS.register_system(SystemsLibrary.Missile)
	ECS.register_system(SystemsLibrary.Collision)
	ECS.register_system(SystemsLibrary.Endfight)

	spawn()

	listener_hero = ECS.add_component(heroNode, ComponentsLibrary.AnswerListener) 	as AnswerListenerComponent
	var comp_spell_hero = ECS.add_component(heroNode, ComponentsLibrary.Spell) as SpellComponent
	comp_spell_hero.init({"spell_hero" : spell_hero, "ulti_hero" : ulti_hero})						#spellname --> scene instance
	answer_listener.append(listener_hero)
	answer_listener.append(ECS.add_component(heroNode, ComponentsLibrary.EmitPArticules))
	damage_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Damage, TagsLibrary.Tag_Hero) as DamageComponent
	damage_comp_hero.init(FileBankUtils.damage, 6)


	ECS.add_component(heroNode, ComponentsLibrary.InputListener)
	ECS.add_component(heroNode, ComponentsLibrary.Movement)
	ECS.add_component(heroNode, ComponentsLibrary.Velocity)

	var comp_end = ECS.add_component(heroNode, ComponentsLibrary.End_fight)
	comp_end.set_end(true)
	var comp_anim_hero = ECS.add_component(heroNode, ComponentsLibrary.Animation) as AnimationComponent
	var anim_name_hero = {comp_anim_hero.anim.left : "anim_left", comp_anim_hero.anim.right : "anim_right", comp_anim_hero.anim.jump : "anim_jump", comp_anim_hero.anim.idle : "anim_idle"}
	var animation_player_hero = heroNode.get_node("animation_hero")
	comp_anim_hero.init(anim_name_hero, animation_player_hero)
	var pos_comp = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp.set_position(Vector2(95,940))

	var hero_health = FileBankUtils.health
	var hero_health_max = FileBankUtils.health_max
	if hero_health <= 0:
		health_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Health) as HealthComponent
		health_comp_hero.init(hero_health_max,hero_health_max)
	else:
		health_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Health, TagsLibrary.Tag_Hero) as HealthComponent
		health_comp_hero.init(hero_health,hero_health_max)

	treasure_comp = ECS.add_component(heroNode, ComponentsLibrary.Treasure, TagsLibrary.Tag_Hero) as TreasureComponent
	treasure_comp.init(FileBankUtils.treasure)

	ECS.add_component(heroNode, ComponentsLibrary.Collision)



	listener_enemy = ECS.add_component(enemyNode, ComponentsLibrary.AnswerListener) as AnswerListenerComponent

	answer_listener.append(listener_enemy)
	answer_listener.append(ECS.add_component(enemyNode, ComponentsLibrary.EmitPArticules))
	ECS.add_component(enemyNode, ComponentsLibrary.Node_Enemy)
	ECS.add_component(enemyNode, ComponentsLibrary.Position)
	ECS.add_component(enemyNode, ComponentsLibrary.End_fight)
	var health_comp_enemy = ECS.add_component(enemyNode, ComponentsLibrary.Health) as HealthComponent
	var enemy_health = health_comp_hero.get_health_max() + (damage_comp_hero.get_damage() * 6)
	health_comp_enemy.init(enemy_health, enemy_health)

	var damage_comp_enemy = ECS.add_component(enemyNode, ComponentsLibrary.Damage) as DamageComponent
	var damage_enemy = int(damage_comp_hero.damage * 0.3)

	damage_comp_enemy.init(damage_enemy,3)

	answerToSpell_hero = ECS.add_component(heroNode, ComponentsLibrary.AnswertoSpell) as AnswertoSpellComponent
	answerToSpell_hero.init({AnswerListenerComponent.answer.true :
																	{AnswertoSpellComponent.property.name :"spell_hero",
																	 AnswertoSpellComponent.property.target : enemyNode,
																	 AnswertoSpellComponent.property.damage : damage_comp_hero.get_damage()}
																	})

	var answerToSpell_enemy = ECS.add_component(enemyNode, ComponentsLibrary.AnswertoSpell) as AnswertoSpellComponent
	answerToSpell_enemy.init({AnswerListenerComponent.answer.false :
																	{AnswertoSpellComponent.property.name :"spell_enemy",
																	 AnswertoSpellComponent.property.target : heroNode,
																	 AnswertoSpellComponent.property.damage : damage_enemy}
																	})
	var comp_spell_enemy = ECS.add_component(enemyNode, ComponentsLibrary.Spell) as SpellComponent
	comp_spell_enemy.init({"spell_enemy" : spell_enemy})

	ECS.add_component(enemyNode, ComponentsLibrary.Collision)

	load_hud(hero_health, hero_health_max, enemy_health, enemy_health)
	ECS.clear_ghosts()

func _process(delta):
	time_label.set_text(str(int(game_timer.get_time_left())))

	if answerToSpell_hero != null:
		answerToSpell_hero.init({AnswerListenerComponent.answer.true :
																	{AnswertoSpellComponent.property.name :"spell_hero",
																	 AnswertoSpellComponent.property.target : enemyNode,
																	 AnswertoSpellComponent.property.damage : damage_comp_hero.get_damage()}
																	})

func spawn() :
	var skin_hero = Scene_transition_data.get_data("skin_hero")
	if skin_hero == 0:
		heroNode = punk.instance()
	elif skin_hero == 1:
		heroNode = girl_white.instance()
	elif skin_hero == 2:
		heroNode = boy_white.instance()
	elif skin_hero == 3:
		heroNode = zombie.instance()
	elif skin_hero == 4:
		heroNode = girl_black.instance()
	elif skin_hero == 5:
		heroNode = robot.instance()
	else:
		heroNode = punk.instance()
	add_child(heroNode)
	CameraUtils.set_camera_root(heroNode)
	CameraUtils.set_offset(Vector2(600, -400))
	CameraUtils.set_zoom(2.5)
	heroNode.get_node("TorchLight").enabled = true
	add_child(enemyNode)
	enemyNode.set_position(Vector2(1700,810))
	var sprite = $Ennemy/Sprite
	sprite.apply_scale(Vector2(3, 3))
	$Ennemy/CollisionShape2D.scale = Vector2(3, 3)

func load_hud( _hero_health : int,  _hero_health_max : int, _enemy_health : int, _enemy_health_max : int):
	var Hud_heroNode = hud_hero.instance()
	add_child(Hud_heroNode)
	Hud_heroNode.set_name("Hud_hero")

	var hud_comp_fight_hero = ECS.add_component(heroNode, ComponentsLibrary.Hud_fight) as HudFightComponent

	hud_comp_fight_hero.init_hero(Hud_heroNode.get_life_hero(),Hud_heroNode.get_life_hero_label(),
						   Hud_heroNode.get_damage(), _hero_health, _hero_health_max)

	var Hud_enemyNode = hud_enemy.instance()
	add_child(Hud_enemyNode)
	Hud_enemyNode.set_name("Hud_enemy")

	var hud_comp_fight_enemy = ECS.add_component(enemyNode, ComponentsLibrary.Hud_fight) as HudFightComponent
	hud_comp_fight_enemy.init_enemy(Hud_enemyNode.get_life_enemy(), Hud_enemyNode.get_life_enemy_label(),
							  Hud_enemyNode.get_damage(), _enemy_health, _enemy_health_max)

	var ScoreNode = score.instance()
	var hud_comp_hero_map = ECS.add_component(heroNode, ComponentsLibrary.Hud_map) as HudMapComponent

	var score_comp = ECS.add_component(heroNode, ComponentsLibrary.Scoreglobal, TagsLibrary.Tag_Hero) as ScoreglobalcounterComponent
	score_comp.init_score(FileBankUtils.good_answer, FileBankUtils.wrong_answer, FileBankUtils.victories)
	score_comp.init_stats(FileBankUtils.good_answer, FileBankUtils.wrong_answer, FileBankUtils.victories, FileBankUtils.defeats)	
	hud_comp_hero_map.init_hero(ScoreNode.get_treasure(), treasure_comp.get_treasure(),
								ScoreNode.get_score(), score_comp.compute_score())
	var hud_comp_hero_treasure = ECS.add_component(heroNode, ComponentsLibrary.Hud_treasure) as HudTreasureComponent
	hud_comp_hero_treasure.init_treasure(ScoreNode.get_treasure(), treasure_comp.get_treasure())
	
func _on_game_timer_timeout():
	time_label.hide()
	var calcul_instance = calcul.instance()
	add_child(calcul_instance)
	var questions = Scene_transition_data.get_data("questions")
	var constants = Scene_transition_data.get_data("constants")
	calcul_instance.setup_question(questions, constants)
	calcul_instance.set_answer_listener(answer_listener)
	listener_hero.init(calcul_instance, calcul, questions, constants)
	listener_enemy.init(calcul_instance, calcul, questions, constants)
	ECS.add_component(heroNode, ComponentsLibrary.Node_Hero)
