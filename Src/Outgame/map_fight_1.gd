extends Node2D

onready var hero   			= preload("res://Src/Ingame/characters/hero.tscn")
onready var enemy 			= preload("res://Src/Ingame/characters/Ennemy.tscn")
onready var hud_hero    	= preload("res://Assets/Textures/hud/hud_hero.tscn")
onready var hud_enemy    	= preload("res://Assets/Textures/hud/hud_enemy.tscn")
onready var calcul 			= preload("res://Src/Ingame/Animation/calcul.tscn")
onready var spell_hero		= preload("res://Src/Ingame/Animation/spell_hero.tscn")
onready var ulti_hero		= preload("res://Src/Ingame/Animation/ulti_hero.tscn")
onready var spell_enemy		= preload("res://Src/Ingame/Animation/spell_enemy.tscn")

onready var score			= 	preload("res://Assets/Textures/hud/hud_score.tscn")

onready var time_label = get_node("sol/time_label")
onready var game_timer = get_node("game_timer")

onready var heroNode = hero.instance()
onready var enemyNode = enemy.instance()

var calcul_instance = null

func _ready():

	var answer_listener : Array = []

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

	var listener_hero : Component = ECS.add_component(heroNode, ComponentsLibrary.AnswerListener) 	as AnswerListenerComponent
	listener_hero.init(calcul_instance, calcul)
	var comp_spell_hero = ECS.add_component(heroNode, ComponentsLibrary.Spell) as SpellComponent
	comp_spell_hero.init({"spell_hero" : spell_hero, "ulti_hero" : ulti_hero})						#spellname --> scene instance
	answer_listener.append(listener_hero)
	answer_listener.append(ECS.add_component(heroNode, ComponentsLibrary.EmitPArticules))
	var damage_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Damage, TagsLibrary.Tag_Hero) as DamageComponent
#	damage_comp_hero.init(damage_comp_hero.damage)
	damage_comp_hero.init(FileBankUtils.damage)


	ECS.add_component(heroNode, ComponentsLibrary.InputListener)
	ECS.add_component(heroNode, ComponentsLibrary.Movement)
	ECS.add_component(heroNode, ComponentsLibrary.Velocity)
	ECS.add_component(heroNode, ComponentsLibrary.Node_Hero)

	var comp_anim_hero = ECS.add_component(heroNode, ComponentsLibrary.Animation) as AnimationComponent
	var anim_name_hero = {comp_anim_hero.anim.left : "anim_left", comp_anim_hero.anim.right : "anim_right", comp_anim_hero.anim.jump : "anim_jump", comp_anim_hero.anim.idle : "anim_idle"}
	var animation_player_hero = heroNode.get_node("animation_hero")
	comp_anim_hero.init(anim_name_hero, animation_player_hero)
	var hero_pos = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	hero_pos.set_position(Vector2(100,535))

	var health_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Health, TagsLibrary.Tag_Hero) as HealthComponent
	health_comp_hero.init(FileBankUtils.health,FileBankUtils.health)

	ECS.add_component(heroNode, ComponentsLibrary.Collision)



	var listener_enemy : Component = ECS.add_component(enemyNode, ComponentsLibrary.AnswerListener) as AnswerListenerComponent
	listener_enemy.init(calcul_instance, calcul)


	answer_listener.append(listener_enemy)
	answer_listener.append(ECS.add_component(enemyNode, ComponentsLibrary.EmitPArticules))
	ECS.add_component(enemyNode, ComponentsLibrary.Node_Enemy)
	ECS.add_component(enemyNode, ComponentsLibrary.Position)
	var health_comp_enemy = ECS.add_component(enemyNode, ComponentsLibrary.Health) as HealthComponent
	health_comp_enemy.init(health_comp_hero.health + (damage_comp_hero.damage * 6),health_comp_hero.health + (damage_comp_hero.damage * 6))

	var damage_comp_enemy = ECS.add_component(enemyNode, ComponentsLibrary.Damage) as DamageComponent
	var damage_enemy = int(damage_comp_hero.damage * 0.3)

	damage_comp_enemy.init(damage_enemy)


	var answerToSpell_hero = ECS.add_component(heroNode, ComponentsLibrary.AnswertoSpell) as AnswertoSpellComponent
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

	calcul_instance.set_answer_listener(answer_listener)

	load_hud()

	ECS.clear_ghosts()

func _process(delta):
	time_label.set_text(str(int(game_timer.get_time_left())))



func spawn() :

	add_child(heroNode)
	add_child(enemyNode)
	enemyNode.set_position(Vector2(750,275))
	var sprite = $Ennemy/Sprite
	sprite.apply_scale(Vector2(4, 4))
	$Ennemy/CollisionShape2D.scale = Vector2(4, 4)
	calcul_instance = calcul.instance()
	calcul_instance.hide()
	add_child(calcul_instance)

func load_hud():
	var Hud_heroNode = hud_hero.instance()
	add_child(Hud_heroNode)
	Hud_heroNode.set_name("Hud_hero")

	var hud_comp = ECS.add_component(heroNode, ComponentsLibrary.Hud) as HudComponent

	hud_comp.init_hero_map(Hud_heroNode.get_life_hero(),Hud_heroNode.get_life_hero_label(),
	Hud_heroNode.get_life_hero_max(), Hud_heroNode.get_damage(), Hud_heroNode.get_tween())
	
	var Hud_enemyNode = hud_enemy.instance()
	add_child(Hud_enemyNode)
	Hud_enemyNode.set_name("Hud_enemy")

	var hud_enemy_comp = ECS.add_component(enemyNode, ComponentsLibrary.Hud) as HudComponent
	hud_enemy_comp.init_enemy(Hud_enemyNode.get_life_enemy(), Hud_enemyNode.get_life_enemy_label(),
	Hud_enemyNode.get_life_ennemy_max(),Hud_enemyNode.get_damage())

	var ScoreNode = score.instance()
	var score_comp = ECS.add_component(heroNode, ComponentsLibrary.Scoreglobal, TagsLibrary.Tag_Hero) as ScoreglobalcounterComponent
	score_comp.init_score(FileBankUtils.good_answer, FileBankUtils.wrong_answer, FileBankUtils.victories)
	score_comp.init_stats(FileBankUtils.good_answer, FileBankUtils.wrong_answer, FileBankUtils.victories, FileBankUtils.defeats)	
	hud_comp.init_hero_fight(ScoreNode.get_treasure(), ScoreNode.get_score())
	
func _on_game_timer_timeout():

	time_label.hide()
	calcul_instance.show()





