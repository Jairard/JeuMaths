extends Node2D

onready var enemy 			= 	preload("res://Src/Ingame/characters/Ennemy.tscn")
onready var hero 			= 	preload("res://Src/Ingame/characters/hero.tscn")
onready var hud 			= 	preload("res://Assets/Textures/hud/hud_hero.tscn")
onready var eye 			= 	preload("res://Src/Ingame/characters/eye.tscn")
onready var monster 		= 	preload("res://Src/Ingame/characters/monsters.tscn")
onready var spawn_fire 		= 	preload("res://Src/Ingame/FX/Fire.tscn")
onready var portal 			= 	preload("res://Src/Ingame/FX/smoke_2.tscn")

onready var gold			= 	preload("res://Src/Ingame/characters/gold.tscn")
onready var damage			= 	preload("res://Src/Ingame/characters/Damage.tscn")
onready var health			= 	preload("res://Src/Ingame/characters/Health.tscn")

onready var score			= 	preload("res://Assets/Textures/hud/hud_score.tscn")

var health_comp_hero : Component = null
var pos_comp : Component = null
var heroNode = null

export var color_game = Color("#00000000")
export var color_tumble = Color("#000000")

var file = File.new()
var dict = {}
	
func _ready():
	ECS.register_system(SystemsLibrary.Move)
	ECS.register_system(SystemsLibrary.Input)
	ECS.register_system(SystemsLibrary.Animation)
	ECS.register_system(SystemsLibrary.Collision)
	ECS.register_system(SystemsLibrary.Patrol)
	ECS.register_system(SystemsLibrary.Missile)
	ECS.register_system(SystemsLibrary.Hud)
	ECS.register_system(SystemsLibrary.Bullet)
	ECS.register_system(SystemsLibrary.Bounce)

	load_characters()
	var anim = AnimationUtils.scene_fade_out(self)
	yield(anim, "animation_finished")
	var tween = AnimationUtils.tween_fade_out(self)
	yield(tween, "tween_completed")
	$CanvasModulate.hide()	
	_load_ressources()
	_load_monsters()
	load_gold()
	ECS.clear_ghosts()

func load_characters() :

	var enemyNode = enemy.instance()
#	add_child(enemyNode)


	heroNode = hero.instance()
	add_child(heroNode)


	var HudNode = hud.instance()
	add_child(HudNode)
	HudNode.set_name("Hud")

	var ScoreNode = score.instance()
	add_child(ScoreNode)
	ScoreNode.set_name("Score")

	var portalNode = portal.instance()
	add_child(portalNode)
	portalNode.set_position(Vector2(16300,550))

#	var enemy_pos_comp = ECS.add_component(enemyNode, ComponentsLibrary.Position) as PositionComponent
#	enemy_pos_comp.set_position(Vector2(3500,300))														#Appears at (0,0)


	ECS.add_component(heroNode, ComponentsLibrary.InputListener)
	ECS.add_component(heroNode, ComponentsLibrary.Bounce)


	pos_comp = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp.set_position(Vector2(5000,0))
	ECS.add_component(heroNode, ComponentsLibrary.Collision)
	ECS.add_component(heroNode, ComponentsLibrary.Velocity)
	var gravity_comp = ECS.add_component(heroNode, ComponentsLibrary.Gravity) as GravityComponent
	gravity_comp.set_gravity(20)
	var move_comp = ECS.add_component(heroNode, ComponentsLibrary.Movement) as MovementComponent
	move_comp.set_jump_impulse(800)
	move_comp.set_lateral_velocity(350)
	var comp_anim_hero = ECS.add_component(heroNode, ComponentsLibrary.Animation) as AnimationComponent
	var anim_name_hero = {comp_anim_hero.anim.left : "anim_left", comp_anim_hero.anim.right : "anim_right", 
						  comp_anim_hero.anim.jump : "anim_jump", comp_anim_hero.anim.idle : "anim_idle",
						  comp_anim_hero.anim.colliding : "anim_colliding"}
	var animation_player_hero = heroNode.get_node("animation_hero")
	comp_anim_hero.init(anim_name_hero, animation_player_hero)


	var hud_comp = ECS.add_component(heroNode, ComponentsLibrary.Hud) as HudComponent

	hud_comp.init_hero_map(HudNode.get_life_hero(),HudNode.get_life_hero_label(),
	HudNode.get_life_hero_max(), HudNode.get_damage())

	hud_comp.init_hero_fight(ScoreNode.get_treasure(), ScoreNode.get_score())


	health_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Health, TagsLibrary.Tag_Hero) as HealthComponent
	health_comp_hero.init(FileBankUtils.health_max,FileBankUtils.health_max)
	# Refill the health
	FileBankUtils.health = health_comp_hero.get_health_max()
	health_comp_hero.set_health(FileBankUtils.health)

	var treasure_comp = ECS.add_component(heroNode, ComponentsLibrary.Treasure, TagsLibrary.Tag_Hero) as TreasureComponent
	treasure_comp.init(FileBankUtils.treasure)


	var damage_comp = ECS.add_component(heroNode, ComponentsLibrary.Damage, TagsLibrary.Tag_Hero) as DamageComponent
	damage_comp.init(FileBankUtils.damage)

	var score_comp = ECS.add_component(heroNode, ComponentsLibrary.Scoreglobal, TagsLibrary.Tag_Hero) as ScoreglobalcounterComponent
	score_comp.init_score(FileBankUtils.good_answer, FileBankUtils.wrong_answer, FileBankUtils.victories)
	score_comp.init_stats(FileBankUtils.good_answer, FileBankUtils.wrong_answer, FileBankUtils.victories, FileBankUtils.defeats)	

func combat(valeur) :
	if valeur == 0 :
		Scene_changer.change_scene(FileBankUtils.loaded_scenes["playing_map"][1]["map_fire"])



func _on_Button_pressed():
	save_ressources()
	Scene_changer.change_scene("res://Src/Outgame/Multiscenes.tscn")



func _load_ressources():

#	file.open("res://log_in/pseudo.json", File.READ)
#	dict = parse_json(file.get_as_text())
#	GLOBAL.pv_hero_max = dict["health_max"]
#	GLOBAL.pv_hero = dict["health"]
#	file.close()
	pass
func save_ressources():
#	file.open("res://log_in/pseudo.json", File.WRITE)
#	var dict = to_json(dict)
#	file.store_string(dict)
#	file.close()
	pass
func _on_Timer_timeout():
	_load_bullets()

func _process(delta):
	if health_comp_hero.get_health() <= 0:
		if pos_comp.get_position().x <= 11500:
			Scene_changer.change_scene(FileBankUtils.loaded_scenes["death"])
		if pos_comp.get_position().x >11500 and pos_comp.get_position().x <= 20000:
			tween(Vector2(11500, 500))
			health_comp_hero.set_health(health_comp_hero.get_health_max())			
		if pos_comp.get_position().x >20000:
			tween(Vector2(20000, 500))
			health_comp_hero.set_health(health_comp_hero.get_health_max())
		

func tween(pos : Vector2):
		var tween = Tween.new()
		add_child(tween)
		$CanvasModulate.show()
		tween.interpolate_property($CanvasModulate, "color", color_game, color_tumble, 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		tween.start()
		yield(tween, "tween_completed")
		remove_child(tween)
		
		$Control/ColorRect.show()
		$Control/AnimationPlayer.play("test")
		yield($Control/AnimationPlayer, "animation_finished")
	
		pos_comp.set_position(pos)
		$Control/ColorRect.hide()
		$CanvasModulate.hide()

func _load_monsters():
	EntitiesUtils.create_monster(self, monster, Vector2(1080, 250), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(1900,190), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(2800,360), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(5000,835), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(11280,515), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(12200,515), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(13070,515), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(13970,515), gold, health, damage)


func _load_bullets():
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(7750,0))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(7750,-500))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(7750,-1000))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(7750,-1500))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(7750,-2000))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(7750,-2500))	
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(7750,-3000))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(7750,-3500))

	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(10050,0))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(10050,-500))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(10050,-1000))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(10050,-1500))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(10050,-2000))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(10050,-2500))	
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(10050,-3000))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(10050,-3500))
	
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(11900,1250))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(13150,1250))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(14400,1250))

	
func _load_missiles():
	EntitiesUtils.create_missile(self, eye, Vector2(10050,700), heroNode)


func _on_Area2D_body_entered(body):
	_load_missiles()
	
func load_gold():
	EntitiesUtils.create_gold(self, gold, Vector2(5370,-150))
	EntitiesUtils.create_gold(self, gold, Vector2(74500,-150))
	EntitiesUtils.create_gold(self, gold, Vector2(7750,750))
	EntitiesUtils.create_gold(self, gold, Vector2(9050,-150))
	EntitiesUtils.create_gold(self, gold, Vector2(6875,-500))
	EntitiesUtils.create_gold(self, gold, Vector2(9600,-500))
	EntitiesUtils.create_gold(self, gold, Vector2(7200,-1050))
	EntitiesUtils.create_gold(self, gold, Vector2(9300,-1050))
	EntitiesUtils.create_gold(self, gold, Vector2(9600,-1650))
	EntitiesUtils.create_gold(self, gold, Vector2(6875,-1650))
	EntitiesUtils.create_gold(self, gold, Vector2(7250,-2300))
	EntitiesUtils.create_gold(self, gold, Vector2(9250,-2300))
	EntitiesUtils.create_gold(self, gold, Vector2(8200,-2700))
	EntitiesUtils.create_gold(self, gold, Vector2(8330,-2700))
	EntitiesUtils.create_gold(self, gold, Vector2(7400,-3250))
	EntitiesUtils.create_gold(self, gold, Vector2(9175,-3250))
	EntitiesUtils.create_gold(self, gold, Vector2(8200,-3700))
	EntitiesUtils.create_gold(self, gold, Vector2(8300,-3700))
			
