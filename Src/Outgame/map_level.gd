extends Node2D

onready var enemy 			= 	preload("res://Src/Ingame/characters/Ennemy.tscn")
onready var hero 			= 	preload("res://Src/Ingame/characters/hero.tscn")
onready var hud 			= 	preload("res://Assets/Textures/hud/hud_hero.tscn")
onready var rain			= 	preload("res://Src/Ingame/characters/rain.tscn")
onready var eye 			= 	preload("res://Src/Ingame/characters/eye.tscn")
onready var monster 		= 	preload("res://Src/Ingame/characters/monsters.tscn")
onready var spawn_fire 		= 	preload("res://Src/Ingame/FX/Fire.tscn")
#onready var treasure 		= 	preload("res://characters/treasure.tscn")
onready var gold			= 	preload("res://Src/Ingame/characters/gold.tscn")
onready var xp				= 	preload("res://Src/Ingame/characters/Xp.tscn")
onready var damage			= 	preload("res://Src/Ingame/characters/Damage.tscn")
onready var health			= 	preload("res://Src/Ingame/characters/Health.tscn")


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
	
	_load_ressources()
	load_characters()

func spawn_rain():
	RainUtils.spawn_at(2100,2200,20,100,self,rain)		

func load_characters() :
	
	var enemyNode = enemy.instance()
	add_child(enemyNode)
	enemyNode.set_name("enemy")
	
	var heroNode = hero.instance()
	add_child(heroNode)
	heroNode.set_name("hero")
	
	var monsterNode = monster.instance()
	add_child(monsterNode)
	monsterNode.set_name("monster")
	
	var EyeNode = eye.instance()
	add_child(EyeNode)
	EyeNode.set_name("eye")
	
	var HudNode = hud.instance()
	add_child(HudNode)
	HudNode.set_name("Hud")
	
	var FireNode = spawn_fire.instance()
	add_child(FireNode)
	FireNode.set_name("fire")

	

	var enemy_pos_comp = ECS.add_component(enemyNode, ComponentsLibrary.Position) as PositionComponent
	enemy_pos_comp.set_position(Vector2(3500,300))														#Appears at (0,0)
#	print ("enemy :" + str(enemy_pos_comp.get_position()))

	ECS.add_component(heroNode, ComponentsLibrary.InputListener)
	ECS.add_component(heroNode, ComponentsLibrary.Bounce)
	ECS.add_component(heroNode, ComponentsLibrary.Loot)
	var comp_stats_hero = ECS.add_component(heroNode, ComponentsLibrary.Stats) as CharacterstatsComponent
	comp_stats_hero.init_stats()
	var pos_comp = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp.set_position(Vector2(100,400))
	ECS.add_component(heroNode, ComponentsLibrary.Collision)
	ECS.add_component(heroNode, ComponentsLibrary.Velocity)
	var gravity_comp = ECS.add_component(heroNode, ComponentsLibrary.Gravity) as GravityComponent
	gravity_comp.set_gravity(20)
	var move_comp = ECS.add_component(heroNode, ComponentsLibrary.Movement) as MovementComponent
	move_comp.set_jump_impulse(650)
	move_comp.set_lateral_velocity(300)
	var comp_anim_hero = ECS.add_component(heroNode, ComponentsLibrary.Animation) as AnimationComponent
	var anim_name_hero = {comp_anim_hero.anim.left : "anim_left", comp_anim_hero.anim.right : "anim_right", comp_anim_hero.anim.jump : "anim_jump", comp_anim_hero.anim.idle : "anim_idle"}
	var animation_player_hero = heroNode.get_node("animation_hero")
	comp_anim_hero.init(anim_name_hero, animation_player_hero)
	
	ECS.add_component(monsterNode, ComponentsLibrary.Position)
	var comp_anim_monster = ECS.add_component(monsterNode, ComponentsLibrary.Animation) as AnimationComponent
	var anim_name_monster = {comp_anim_monster.anim.right : "anim_right"}
	var animation_player_monster = monsterNode.get_node("animation_monster")
	comp_anim_monster.init(anim_name_monster, animation_player_monster)
	var comp_patrol = ECS.add_component(monsterNode, ComponentsLibrary.Patrol) as PatrolComponent
	comp_patrol.init(700,900) 
	var health_comp_monster = ECS.add_component(monsterNode, ComponentsLibrary.Health) as HealthComponent
	health_comp_monster.init(1,1)	
	var lootDict_monster = [ {gold : 10}, {xp : 10}, {health : 10}]#, damage : 50}]#, null : 90} ]
	var loot_comp_monster = ECS.add_component(monsterNode, ComponentsLibrary.Loot) as LootComponent
	loot_comp_monster.init(lootDict_monster, monsterNode.get_node("head"))
	
	var eye_pos_comp = ECS.add_component(EyeNode, ComponentsLibrary.Position) as PositionComponent
	eye_pos_comp.set_position(enemy_pos_comp.get_position())
	var comp_missile = ECS.add_component(EyeNode, ComponentsLibrary.Nodegetid) as NodegetidComponent
	comp_missile.init(heroNode)
	var comp_rotation = ECS.add_component(EyeNode, ComponentsLibrary.Rotation) as RotationComponent
	comp_rotation.set_rotation(true)
	
	ECS.add_component(FireNode, ComponentsLibrary.Bullet)
	ECS.add_component(FireNode, ComponentsLibrary.Collision)
	var fire_pos_comp = ECS.add_component(FireNode, ComponentsLibrary.Position) as PositionComponent
	fire_pos_comp.set_position(Vector2(1000,540))
	
	
	var hud_comp = ECS.add_component(heroNode, ComponentsLibrary.Hud) as HudComponent
	
	hud_comp.init_hero(HudNode.get_life_hero(),HudNode.get_life_hero_label(), 
	HudNode.get_life_hero_max(), HudNode.get_damage(), 
	HudNode.get_xp(), HudNode.get_level(), HudNode.get_treasure())

	
	var health_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Health) as HealthComponent
	health_comp_hero.init(comp_stats_hero.health,comp_stats_hero.health)
	
	var treasure_comp = ECS.add_component(heroNode, ComponentsLibrary.Treasure) as TreasureComponent
	treasure_comp.init(0)
	
	var xp_comp = ECS.add_component(heroNode, ComponentsLibrary.Xp) as XpComponent
	xp_comp.init(0,1)
	
	var damage_comp = ECS.add_component(heroNode, ComponentsLibrary.Damage) as DamageComponent
	damage_comp.init(10)

	
func combat(valeur) :
	if valeur == 0 :
		get_tree().change_scene("res://Src/Outgame/map_fight_1.tscn")
		


func _on_Button_pressed():
	save_ressources()
	get_tree().change_scene("res://Src/Outgame/Multiscenes.tscn")

#func rain_spawn():
#	randomize()
#	var screen_size = get_viewport().size
#	var screen_tile = Vector2(screen_size.x, screen_size.y) / Vector2(64,64)
#
#	_unique()
#	for x in 10 :
#		if unique[x] == [1] :
#			var x_pos = x
#			var i = rain.instance()
#			i.start(Vector2(x_pos * 64 , 0), randi() % 3)
#			self.add_child(i)	
#	return unique


#func _unique():
#	for x in 10 :
#		unique.append([])
#		if randi() % 2 == 1 :
#			unique[x].append(1)
#		else :
#			unique[x].append(0)
#	return unique

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
	
	var FireNode = spawn_fire.instance()
	add_child(FireNode)
	FireNode.set_name("fire")
	
	ECS.add_component(FireNode, ComponentsLibrary.Bullet)
	var fire_pos_comp = ECS.add_component(FireNode, ComponentsLibrary.Position) as PositionComponent
	fire_pos_comp.set_position(Vector2(1000,540))


func _on_Area2D_body_entered(body):  
	spawn_rain()
