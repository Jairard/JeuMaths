extends Node2D

onready var enemy 			= 	preload("res://characters/Ennemy.tscn")
onready var hero 			= 	preload("res://characters/hero.tscn")
onready var hud 			= 	preload("res://hud/hud_hero.tscn")
onready var rain			= 	preload("res://characters/rain.tscn")
onready var eye 			= 	preload("res://characters/eye.tscn")
onready var monster 		= 	preload("res://characters/monsters.tscn")
onready var smoke_spawn		= 	preload("res://particules_2D/smoke_2.tscn")
onready var sparkle_spawn 	=	preload("res://particules_2D/sparkle.tscn")
onready var spawn_fire 		= 	preload("res://particules_2D/Fire.tscn")
onready var treasure 		= 	preload("res://characters/Gold.tscn")
onready var gold			= 	preload("res://characters/treasure.tscn")
#onready var xp			= 	preload("res://characters/xp.tscn")
#onready var health			= 	preload("res://characters/health.tscn")

#var unique = []
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
#	ECS.register_system(SystemsLibrary.Bullet)
	ECS.register_system(SystemsLibrary.Bounce)
#	ECS.register_system(SystemsLibrary.Rain)
	
	_load_ressources()
	charger_intro()

func _process(delta):
	pass

	
func charger_intro() :
	
	load_characters()
	var rot_gold = treasure.instance()
	add_child(rot_gold)
#	rain_spawn()		


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
	
	var rainNode = rain.instance()
	add_child(rainNode)
	rainNode.set_name("rain")
	

	var enemy_pos_comp = ECS.add_component(enemyNode, ComponentsLibrary.Position) as PositionComponent
	enemy_pos_comp.set_position(Vector2(300,300))														#Appears at (0,0)
#	print ("enemy :" + str(enemy_pos_comp.get_position()))
	
	ECS.add_component(rainNode, ComponentsLibrary.Movement)
	ECS.add_component(rainNode, ComponentsLibrary.Position)
#	var rain_spawn = ECS.add_component(rainNode, ComponentsLibrary.Rain) as RainComponent
	
	ECS.add_component(heroNode, ComponentsLibrary.InputListener)
	ECS.add_component(heroNode, ComponentsLibrary.Bounce)
#	ECS.add_component(heroNode, ComponentsLibrary.Loot)
	ECS.add_component(heroNode, ComponentsLibrary.Position)
	ECS.add_component(heroNode, ComponentsLibrary.Movement)
	ECS.add_component(heroNode, ComponentsLibrary.Collision)
	var lootDict_hero = [ {gold : 5}]#, {xp : 10}, {health : 5, damage : 5, null : 90} ]
	var loot_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Loot) as LootComponent
	loot_comp_hero.init(lootDict_hero)
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
	var lootDict_monster = [ {gold : 10}]#, {xp : 10}, {health : 5, damage : 5, null : 90} ]
	var loot_comp_monster = ECS.add_component(monsterNode, ComponentsLibrary.Loot) as LootComponent
	loot_comp_monster.init(lootDict_monster)
	
	var eye_pos_comp = ECS.add_component(EyeNode, ComponentsLibrary.Position) as PositionComponent
	eye_pos_comp.set_position(enemy_pos_comp.get_position())
	var comp_missile = ECS.add_component(EyeNode, ComponentsLibrary.Nodegetid) as NodegetidComponent
	comp_missile.init(heroNode)
	
	ECS.add_component(FireNode, ComponentsLibrary.Bullet)
	var fire_pos_comp = ECS.add_component(FireNode, ComponentsLibrary.Position) as PositionComponent
	fire_pos_comp.set_position(Vector2(1000,540))
	
	
	var hud_comp = ECS.add_component(heroNode, ComponentsLibrary.Hud) as HudComponent
	
	hud_comp.init_hero(HudNode.get_life_hero(),HudNode.get_life_hero_label(), 
	HudNode.get_life_hero_max(), HudNode.get_damage(), 
	HudNode.get_xp(), HudNode.get_level(), HudNode.get_treasure())

	
	var health_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Health) as HealthComponent
	health_comp_hero.init(100,100)
	
	var treasure_comp = ECS.add_component(heroNode, ComponentsLibrary.Treasure) as TreasureComponent
	treasure_comp.init(0)
	
	var xp_comp = ECS.add_component(heroNode, ComponentsLibrary.Xp) as XpComponent
	xp_comp.init(0,1)
	
	var damage_comp = ECS.add_component(heroNode, ComponentsLibrary.Damage) as DamageComponent
	damage_comp.init(10)

	
func combat(valeur) :
	if valeur == 0 :
		get_tree().change_scene("res://map/map_fight.tscn")
		


func _on_Button_pressed():
	dict ["health"] = GLOBAL.pv_hero
	dict ["health_max"] = GLOBAL.pv_hero_max
	dict["xp"] = GLOBAL.xp
	save_ressources()
	get_tree().change_scene("res://map/Start.tscn")

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
	ECS.register_system(SystemsLibrary.Bullet)
	
	var FireNode = spawn_fire.instance()
	add_child(FireNode)
	FireNode.set_name("fire")
	
	ECS.add_component(FireNode, ComponentsLibrary.Bullet)
	var fire_pos_comp = ECS.add_component(FireNode, ComponentsLibrary.Position) as PositionComponent
	fire_pos_comp.set_position(Vector2(1000,540))
