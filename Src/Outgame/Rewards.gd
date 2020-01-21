extends Node2D

onready var hero 			= 	preload("res://Src/Ingame/characters/hero.tscn")
onready var portal 			= 	preload("res://Src/Ingame/FX/smoke_2.tscn")
onready var loot 			= 	preload("res://Src/Ingame/characters/Null.tscn")

onready var gold			= 	preload("res://Src/Ingame/characters/gold.tscn")
onready var xp				= 	preload("res://Src/Ingame/characters/Xp.tscn")
onready var damage			= 	preload("res://Src/Ingame/characters/Damage.tscn")
onready var health			= 	preload("res://Src/Ingame/characters/Health.tscn")

func _ready():
	
	############################################ SYSTEM ############################################################
	
	ECS.register_system(SystemsLibrary.Move)
	ECS.register_system(SystemsLibrary.Input)
	ECS.register_system(SystemsLibrary.Animation)
	ECS.register_system(SystemsLibrary.Collision)
	
	############################################ HERO ############################################################
	var heroNode = hero.instance()						
	add_child(heroNode)
	heroNode.set_name("hero")
	
	ECS.add_component(heroNode, ComponentsLibrary.InputListener)
	ECS.add_component(heroNode, ComponentsLibrary.Loot)

	var health_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Health) as HealthComponent
	health_comp_hero.init(FileBankUtils.health,FileBankUtils.health)
	var pos_comp = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp.set_position(Vector2(100,400))
	ECS.add_component(heroNode, ComponentsLibrary.Collision)
	ECS.add_component(heroNode, ComponentsLibrary.Velocity)
	var gravity_comp = ECS.add_component(heroNode, ComponentsLibrary.Gravity) as GravityComponent
	gravity_comp.set_gravity(20)
	var move_comp = ECS.add_component(heroNode, ComponentsLibrary.Movement) as MovementComponent
	move_comp.set_lateral_velocity(300)
	var comp_anim_hero = ECS.add_component(heroNode, ComponentsLibrary.Animation) as AnimationComponent
	var anim_name_hero = {comp_anim_hero.anim.left : "anim_left", comp_anim_hero.anim.right : "anim_right", comp_anim_hero.anim.jump : "anim_jump", comp_anim_hero.anim.idle : "anim_idle"}
	var animation_player_hero = heroNode.get_node("animation_hero")
	comp_anim_hero.init(anim_name_hero, animation_player_hero)
	
	############################################ LOOT ############################################################
	var lootNode = loot.instance()						
	add_child(lootNode)
	lootNode.set_name("loot")

	ECS.add_component(lootNode, ComponentsLibrary.Collision)
	var pos_comp_loot = ECS.add_component(lootNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp_loot.set_position(Vector2(100,400))

	var health_comp_loot = ECS.add_component(lootNode, ComponentsLibrary.Health) as HealthComponent
	health_comp_loot.init(1,1)	
	var lootdict = [ {gold : 10}, {damage : 5, health : 5, null : 90}]#, damage : 50}]#, null : 90} ]
	var loot_comp = ECS.add_component(lootNode, ComponentsLibrary.Loot) as LootComponent
	loot_comp.init(lootdict, lootNode)#.get_parent().get_node("CollisionShape2D"))
	
	############################################ PORTAL ############################################################
	
	var portalNode = portal.instance()
	add_child(portalNode)
	portalNode.set_name("portal")

	ECS.add_component(portalNode, ComponentsLibrary.Collision)
	var pos_comp_portal = ECS.add_component(portalNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp_portal.set_position(Vector2(600,530))





