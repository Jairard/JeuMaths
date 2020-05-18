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
onready var controller      =	preload("res://Src/Outgame/Touch_controller.tscn")
onready var portal 			= 	preload("res://Src/Ingame/FX/smoke_red.tscn")

var health_comp_hero : Component = null
var pos_comp : Component = null
var heroNode : Node2D = null
var treasure_comp : Component = null
var input : Component = null

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

	
	heroNode = hero.instance()
	add_child(heroNode)
	heroNode.set_name("hero")
	pos_comp = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp.set_position(Vector2(100,300))

	input = ECS.add_component(heroNode, ComponentsLibrary.InputListener) as InputListenerComponent
	var controllerNode = controller.instance()
	add_child(controllerNode)
	controllerNode.set_controller(input, heroNode)
	ECS.add_component(heroNode, ComponentsLibrary.Collision)
	ECS.add_component(heroNode, ComponentsLibrary.Velocity)
	var gravity_comp = ECS.add_component(heroNode, ComponentsLibrary.Gravity) as GravityComponent
	gravity_comp.set_gravity(20)
	var move_comp = ECS.add_component(heroNode, ComponentsLibrary.Movement) as MovementComponent
	move_comp.set_jump_impulse(800)
	move_comp.set_lateral_velocity(350)
	
	var hero_health = FileBankUtils.health_max
	health_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Health, TagsLibrary.Tag_Hero) as HealthComponent
	health_comp_hero.init(hero_health,hero_health)
	health_comp_hero.set_health(health_comp_hero.get_health_max())
	FileBankUtils.health = hero_health

	treasure_comp = ECS.add_component(heroNode, ComponentsLibrary.Treasure, TagsLibrary.Tag_Hero) as TreasureComponent
	treasure_comp.init(FileBankUtils.treasure)

	var damage_comp = ECS.add_component(heroNode, ComponentsLibrary.Damage, TagsLibrary.Tag_Hero) as DamageComponent
	damage_comp.init(FileBankUtils.damage,0)

	_load_monsters()
	load_gold()
	load_platform()

	var portalNode = portal.instance()
	add_child(portalNode)
	ECS.add_component(portalNode, ComponentsLibrary.Collision)
	var pos_comp_portal = ECS.add_component(portalNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp_portal.set_position(Vector2(18200,1900))


	var Hud_heroNode = hud.instance()
	add_child(Hud_heroNode)
	Hud_heroNode.set_name("Hud_hero")

	var ScoreNode = score.instance()
	add_child(ScoreNode)
	ScoreNode.set_hero_node(heroNode)

	var score_comp = ECS.add_component(heroNode, ComponentsLibrary.Scoreglobal, TagsLibrary.Tag_Hero) as ScoreglobalcounterComponent
	score_comp.init_score(FileBankUtils.good_answer, FileBankUtils.wrong_answer, FileBankUtils.victories)
	score_comp.init_stats(FileBankUtils.good_answer, FileBankUtils.wrong_answer, FileBankUtils.victories, FileBankUtils.defeats)

	var hud_comp_hero_fight = ECS.add_component(heroNode, ComponentsLibrary.Hud_fight) as HudFightComponent

	hud_comp_hero_fight.init_hero(Hud_heroNode.get_life_hero(),Hud_heroNode.get_life_hero_label(),
						   Hud_heroNode.get_damage(), hero_health, hero_health)
	
	var hud_comp_hero_map = ECS.add_component(heroNode, ComponentsLibrary.Hud_map) as HudMapComponent
	hud_comp_hero_map.init_hero(ScoreNode.get_treasure(), treasure_comp.get_treasure(),
								ScoreNode.get_score(), score_comp.compute_score())
	
	var hud_comp_hero_treasure = ECS.add_component(heroNode, ComponentsLibrary.Hud_treasure) as HudTreasureComponent
	hud_comp_hero_treasure.init_treasure(ScoreNode.get_treasure(), treasure_comp.get_treasure())

func _process(delta):
	if health_comp_hero.get_health() <= 0 :
		if pos_comp.get_position().x <= 6300:
			Fade.checkpoint(heroNode, Vector2(100,300))
		if pos_comp.get_position().x >6300:
			Fade.checkpoint(heroNode, Vector2(6300,700))
		treasure_comp.set_treasure(treasure_comp.get_treasure() *  0.7)
		FileBankUtils.treasure *= 0.7
		health_comp_hero.set_health(health_comp_hero.get_health_max())

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
