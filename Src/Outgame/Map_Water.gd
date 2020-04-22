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
var pos_comp : Component = null
var heroNode : Node2D = null

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
	pos_comp.set_position(Vector2(100,550))

	ECS.add_component(heroNode, ComponentsLibrary.InputListener)
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


	var treasure_comp = ECS.add_component(heroNode, ComponentsLibrary.Treasure, TagsLibrary.Tag_Hero) as TreasureComponent
	treasure_comp.init(FileBankUtils.treasure)


	var damage_comp = ECS.add_component(heroNode, ComponentsLibrary.Damage, TagsLibrary.Tag_Hero) as DamageComponent
	damage_comp.init(FileBankUtils.damage,0)

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
	ScoreNode.set_hero_node(heroNode)
	
	var score_comp = ECS.add_component(heroNode, ComponentsLibrary.Scoreglobal, TagsLibrary.Tag_Hero) as ScoreglobalcounterComponent
	score_comp.init_score(FileBankUtils.good_answer, FileBankUtils.wrong_answer, FileBankUtils.victories)
	score_comp.init_stats(FileBankUtils.good_answer, FileBankUtils.wrong_answer, FileBankUtils.victories, FileBankUtils.defeats)

	var Hud_heroNode = hud.instance()
	add_child(Hud_heroNode)
	Hud_heroNode.set_name("Hud_hero")

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
		if pos_comp.get_position().x <= 9500:
			Fade.checkpoint(heroNode, Vector2(100,550))
		if pos_comp.get_position().x >9500:
			Fade.checkpoint(heroNode, Vector2(9500,500))

func _on_Button_pressed():
	Fade.change_scene(FileBankUtils.loaded_scenes["sign_in"])


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
