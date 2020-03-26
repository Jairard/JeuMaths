extends Node2D

onready var hero 			= 	preload("res://Src/Ingame/characters/hero.tscn")
onready var portal 			= 	preload("res://Src/Ingame/FX/smoke_green.tscn")
onready var loot 			= 	preload("res://Src/Ingame/characters/Null.tscn")
onready var hud 			= 	preload("res://Assets/Textures/hud/hud_hero.tscn")

onready var gold			= 	preload("res://Src/Ingame/characters/gold.tscn")
onready var damage			= 	preload("res://Src/Ingame/characters/Damage.tscn")
onready var health			= 	preload("res://Src/Ingame/characters/Health.tscn")

onready var score			= 	preload("res://Assets/Textures/hud/hud_score.tscn")

func _ready():

	ECS.register_system(SystemsLibrary.Move)
	ECS.register_system(SystemsLibrary.Input)
	ECS.register_system(SystemsLibrary.Animation)
	ECS.register_system(SystemsLibrary.Collision)
	ECS.register_system(SystemsLibrary.Hud)


				
	var heroNode = hero.instance()
	add_child(heroNode)
	heroNode.set_name("hero")

	ECS.add_component(heroNode, ComponentsLibrary.InputListener)
	ECS.add_component(heroNode, ComponentsLibrary.Loot)

	var health_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Health, TagsLibrary.Tag_Hero) as HealthComponent
#	print ("health : ", health_comp_hero.get_health())
#	print ("health_max : ", health_comp_hero.get_health_max())
	var hero_health = FileBankUtils.health
	health_comp_hero.init(FileBankUtils.health,FileBankUtils.health)
	var pos_comp = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp.set_position(Vector2(100,400))
	ECS.add_component(heroNode, ComponentsLibrary.Collision)
	ECS.add_component(heroNode, ComponentsLibrary.Velocity)
	var treasure_comp = ECS.add_component(heroNode, ComponentsLibrary.Treasure, TagsLibrary.Tag_Hero) as TreasureComponent	
	var damage_comp = ECS.add_component(heroNode, ComponentsLibrary.Damage, TagsLibrary.Tag_Hero) as DamageComponent
	var gravity_comp = ECS.add_component(heroNode, ComponentsLibrary.Gravity) as GravityComponent
	gravity_comp.set_gravity(20)
	var move_comp = ECS.add_component(heroNode, ComponentsLibrary.Movement) as MovementComponent
	move_comp.set_lateral_velocity(300)
	var comp_anim_hero = ECS.add_component(heroNode, ComponentsLibrary.Animation) as AnimationComponent
	var anim_name_hero = {comp_anim_hero.anim.left : "anim_left", comp_anim_hero.anim.right : "anim_right", comp_anim_hero.anim.jump : "anim_jump", comp_anim_hero.anim.idle : "anim_idle"}
	var animation_player_hero = heroNode.get_node("animation_hero")
	comp_anim_hero.init(anim_name_hero, animation_player_hero)

	var lootNode = loot.instance()
	add_child(lootNode)
	lootNode.set_name("loot")

	ECS.add_component(lootNode, ComponentsLibrary.Collision)
	var pos_comp_loot = ECS.add_component(lootNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp_loot.set_position(Vector2(100,500))

	var health_comp_loot = ECS.add_component(lootNode, ComponentsLibrary.Health) as HealthComponent
	health_comp_loot.init(1,1)
	var lootdict = [ {gold : 10}, {damage : 5, health : 5, null : 90}]#, damage : 50}]#, null : 90} ]
	var loot_comp = ECS.add_component(lootNode, ComponentsLibrary.Loot) as LootComponent
	loot_comp.init(lootdict, lootNode)


	var portalNode = portal.instance()
	add_child(portalNode)
	portalNode.set_name("portal")

	ECS.add_component(portalNode, ComponentsLibrary.Collision)
	var pos_comp_portal = ECS.add_component(portalNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp_portal.set_position(Vector2(600,530))

	var HudNode = hud.instance()
	add_child(HudNode)

	var ScoreNode = score.instance()
	add_child(ScoreNode)
	ScoreNode.set_name("Score")
	
	var score_comp = ECS.add_component(heroNode, ComponentsLibrary.Scoreglobal, TagsLibrary.Tag_Hero) as ScoreglobalcounterComponent
	score_comp.init_score(FileBankUtils.good_answer, FileBankUtils.wrong_answer, FileBankUtils.victories)
	
	var hud_comp_hero_fight = ECS.add_component(heroNode, ComponentsLibrary.Hud_fight) as HudFightComponent

	hud_comp_hero_fight.init_hero(HudNode.get_life_hero(),HudNode.get_life_hero_label(), 
									HudNode.get_damage(), hero_health, hero_health)

	var hud_comp_hero_map = ECS.add_component(heroNode, ComponentsLibrary.Hud_map) as HudMapComponent
	hud_comp_hero_map.init_hero(ScoreNode.get_treasure(), treasure_comp.get_treasure(), 
								ScoreNode.get_score(), score_comp.compute_score())
								
	var hud_comp_hero_treasure = ECS.add_component(heroNode, ComponentsLibrary.Hud_treasure) as HudTreasureComponent
	hud_comp_hero_treasure.init_treasure(ScoreNode.get_treasure(), treasure_comp.get_treasure())
	
	ECS.clear_ghosts()
