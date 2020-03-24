extends Node2D

onready var hero 			= 	preload("res://Src/Ingame/characters/hero.tscn")
onready var hud 			= 	preload("res://Assets/Textures/hud/hud_hero.tscn")
onready var score			= 	preload("res://Assets/Textures/hud/hud_score.tscn")

onready var monster 		= 	preload("res://Src/Ingame/characters/monsters.tscn")
onready var spawn_fire 		= 	preload("res://Src/Ingame/FX/Fire.tscn")
onready var gold			= 	preload("res://Src/Ingame/characters/gold.tscn")
onready var damage			= 	preload("res://Src/Ingame/characters/Damage.tscn")
onready var health			= 	preload("res://Src/Ingame/characters/Health.tscn")
onready var platform		= 	preload("res://Src/Ingame/characters/Moving_platform.tscn")

onready var portal 			= 	preload("res://Src/Ingame/FX/smoke_red.tscn")

var health_comp_hero : Component = null
var hero_pos : Component = null
var heroNode = null

func _ready():
	var anim = AnimationUtils.canvas_fade_in(self)
	yield(anim, "animation_finished")
	var anim_rect = AnimationUtils.rect_fade_in(self)
	yield(anim_rect, "animation_finished")
	ECS.register_system(SystemsLibrary.Move)
	ECS.register_system(SystemsLibrary.Input)
	ECS.register_system(SystemsLibrary.Animation)
	ECS.register_system(SystemsLibrary.Collision)
	ECS.register_system(SystemsLibrary.Patrol)
	ECS.register_system(SystemsLibrary.Missile)
	ECS.register_system(SystemsLibrary.Hud)
	ECS.register_system(SystemsLibrary.Bullet)
	ECS.register_system(SystemsLibrary.Bounce)

	
	heroNode = hero.instance()
	add_child(heroNode)
	heroNode.set_name("hero")
	hero_pos = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	hero_pos.set_position(Vector2(300,300))

	ECS.add_component(heroNode, ComponentsLibrary.InputListener)
	ECS.add_component(heroNode, ComponentsLibrary.Collision)
	ECS.add_component(heroNode, ComponentsLibrary.Velocity)
	var gravity_comp = ECS.add_component(heroNode, ComponentsLibrary.Gravity) as GravityComponent
	gravity_comp.set_gravity(20)
	var move_comp = ECS.add_component(heroNode, ComponentsLibrary.Movement) as MovementComponent
	move_comp.set_jump_impulse(800)
	move_comp.set_lateral_velocity(350)
	var hero_health = FileBankUtils.health
	health_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Health, TagsLibrary.Tag_Hero) as HealthComponent
	health_comp_hero.init(FileBankUtils.health_max,FileBankUtils.health_max)


	var treasure_comp = ECS.add_component(heroNode, ComponentsLibrary.Treasure, TagsLibrary.Tag_Hero) as TreasureComponent
	treasure_comp.init(FileBankUtils.treasure)


	var damage_comp = ECS.add_component(heroNode, ComponentsLibrary.Damage, TagsLibrary.Tag_Hero) as DamageComponent
	damage_comp.init(FileBankUtils.damage)

	_load_monsters()
	load_gold()
	load_platform()

	var portalNode = portal.instance()
	add_child(portalNode)
	ECS.add_component(portalNode, ComponentsLibrary.Collision)
	var pos_comp_portal = ECS.add_component(portalNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp_portal.set_position(Vector2(18200,1900))
	
	
	var HudNode = hud.instance()
	add_child(HudNode)

	var ScoreNode = score.instance()
	add_child(ScoreNode)
	ScoreNode.set_name("Score")

	var hud_comp = ECS.add_component(heroNode, ComponentsLibrary.Hud) as HudComponent

	hud_comp.init_hero_map(HudNode.get_life_hero(),HudNode.get_life_hero_label(),
						   HudNode.get_damage(), hero_health, hero_health)

	hud_comp.init_hero_fight(ScoreNode.get_treasure(), ScoreNode.get_score())
	var score_comp = ECS.add_component(heroNode, ComponentsLibrary.Scoreglobal, TagsLibrary.Tag_Hero) as ScoreglobalcounterComponent
	score_comp.init_score(FileBankUtils.good_answer, FileBankUtils.wrong_answer, FileBankUtils.victories)
	score_comp.init_stats(FileBankUtils.good_answer, FileBankUtils.wrong_answer, FileBankUtils.victories, FileBankUtils.defeats)	

func _load_monsters():
	EntitiesUtils.create_monster(self, monster, Vector2(4000,325), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(5200,325), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(8750,1220), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(10750,265), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(11900,20), gold, health, damage)


func _load_bullets():
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(5280,800))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(11800,790))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(13400,790))	


func load_gold():
	EntitiesUtils.create_gold(self, gold, Vector2(7150,1000))
	EntitiesUtils.create_gold(self, gold, Vector2(7490,1000))
	EntitiesUtils.create_gold(self, gold, Vector2(7820,1000))
	
	EntitiesUtils.create_gold(self, gold, Vector2(2350,-250))
	EntitiesUtils.create_gold(self, gold, Vector2(2750,-380))
	EntitiesUtils.create_gold(self, gold, Vector2(3250,-250))
	EntitiesUtils.create_gold(self, gold, Vector2(3650,-380))
	EntitiesUtils.create_gold(self, gold, Vector2(4150,-250))
	EntitiesUtils.create_gold(self, gold, Vector2(4550,-380))
	EntitiesUtils.create_gold(self, gold, Vector2(7750,-250))
	EntitiesUtils.create_gold(self, gold, Vector2(8150,-380))
	EntitiesUtils.create_gold(self, gold, Vector2(8650,-250))
	EntitiesUtils.create_gold(self, gold, Vector2(9050,-380))
	EntitiesUtils.create_gold(self, gold, Vector2(9450,-250))
	EntitiesUtils.create_gold(self, gold, Vector2(9850,-380))

func load_platform():
	EntitiesUtils.create_platform(self, platform, Vector2(1750,-100), Vector2(1950,-100),  3) 
	EntitiesUtils.create_platform(self, platform, Vector2(2250,-200), Vector2(2450,-200),  2) 
	EntitiesUtils.create_platform(self, platform, Vector2(2650,-200), Vector2(2850,-200),  3.5)
	EntitiesUtils.create_platform(self, platform, Vector2(3150,-300), Vector2(3350,-300),  2.5)
	EntitiesUtils.create_platform(self, platform, Vector2(3550,-200), Vector2(3750,-200),  1.5)
	EntitiesUtils.create_platform(self, platform, Vector2(4050,-200), Vector2(4250,-200),  3)
	EntitiesUtils.create_platform(self, platform, Vector2(4450,-200), Vector2(4650,-200),  2)

	EntitiesUtils.create_platform(self, platform, Vector2(4950,-300), Vector2(5150,-300),  3.5) 
	EntitiesUtils.create_platform(self, platform, Vector2(5350,-300), Vector2(5550,-300),  2.5) 
	EntitiesUtils.create_platform(self, platform, Vector2(5850,-200), Vector2(6050,-200),  1.5)
	EntitiesUtils.create_platform(self, platform, Vector2(6250,-200), Vector2(6450,-200),  3)
	EntitiesUtils.create_platform(self, platform, Vector2(6750,-200), Vector2(6950,-200),  2)
	EntitiesUtils.create_platform(self, platform, Vector2(7150,-300), Vector2(7350,-300),  3.5)
	EntitiesUtils.create_platform(self, platform, Vector2(7650,-200), Vector2(7850,-200),  2.5)

	EntitiesUtils.create_platform(self, platform, Vector2(8050,-200), Vector2(8250,-200),  1.5) 
	EntitiesUtils.create_platform(self, platform, Vector2(8550,-200), Vector2(8750,-200),  3) 
	EntitiesUtils.create_platform(self, platform, Vector2(8950,-200), Vector2(9150,-200),  2)
	EntitiesUtils.create_platform(self, platform, Vector2(9450,-100), Vector2(9650,-100),  3.5)
	EntitiesUtils.create_platform(self, platform, Vector2(9850,-100), Vector2(10050,-100),  1)


func _on_Timer_timeout():
	_load_bullets()
