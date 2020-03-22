extends Node2D

onready var hero 			= 	preload("res://Src/Ingame/characters/hero.tscn")
onready var hud 			= 	preload("res://Assets/Textures/hud/hud_hero.tscn")
onready var score			= 	preload("res://Assets/Textures/hud/hud_score.tscn")

onready var monster 		= 	preload("res://Src/Ingame/characters/monsters.tscn")
onready var spawn_fire 		= 	preload("res://Src/Ingame/FX/Fire.tscn")
onready var gold			= 	preload("res://Src/Ingame/characters/gold.tscn")
onready var damage			= 	preload("res://Src/Ingame/characters/Damage.tscn")
onready var health			= 	preload("res://Src/Ingame/characters/Health.tscn")

onready var portal 			= 	preload("res://Src/Ingame/FX/smoke_red.tscn")

var health_comp_hero : Component = null
var hero_pos : Component = null
var heroNode = null

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
	hero_pos = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	hero_pos.set_position(Vector2(9500,500))

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

func _on_Button_pressed():
	Scene_changer.change_scene("res://Src/Outgame/Signin.tscn")


func _on_Timer_timeout():
	_load_bullets()

func _load_monsters():
	EntitiesUtils.create_monster(self, monster, Vector2(1640,-220), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(3495,150), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(4345,150), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(6650,1295), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(8050,1040), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(14800,1930), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(16500,1930), gold, health, damage)


func _load_bullets():
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(10920,600))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(12120,600))


func load_gold():
	EntitiesUtils.create_gold(self, gold, Vector2(2480,-150))
	EntitiesUtils.create_gold(self, gold, Vector2(3300,600))
	EntitiesUtils.create_gold(self, gold, Vector2(5500,1220))
	EntitiesUtils.create_gold(self, gold, Vector2(6900,950))
	EntitiesUtils.create_gold(self, gold, Vector2(7960,700))
	EntitiesUtils.create_gold(self, gold, Vector2(7875,-200))
	EntitiesUtils.create_gold(self, gold, Vector2(9510,0))
	EntitiesUtils.create_gold(self, gold, Vector2(8350,-750))
	EntitiesUtils.create_gold(self, gold, Vector2(8350,-1200))
	EntitiesUtils.create_gold(self, gold, Vector2(8350,-1600))
	EntitiesUtils.create_gold(self, gold, Vector2(8730,-1350))
	EntitiesUtils.create_gold(self, gold, Vector2(8730,-850))
	EntitiesUtils.create_gold(self, gold, Vector2(9230,50))
	EntitiesUtils.create_gold(self, gold, Vector2(15980,1100))
	EntitiesUtils.create_gold(self, gold, Vector2(17290,1400))
