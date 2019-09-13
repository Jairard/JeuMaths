extends Node2D

onready var enemy 			= 	preload("res://characters/Ennemy.tscn")
onready var hero 			= 	preload("res://characters/hero.tscn")
onready var hud 			= 	preload("res://hud/hud_hero.tscn")
onready var spawn_rain 		= 	preload("res://characters/rain.tscn")
onready var rains			= 	preload("res://characters/rain.tscn")
onready var eye 			= 	preload("res://characters/eye.tscn")
onready var monster 		= 	preload("res://characters/monsters.tscn")
onready var treasure 		= 	preload("res://characters/treasure.tscn")
onready var smoke_spawn		= 	preload("res://particules_2D/smoke_2.tscn")
onready var sparkle_spawn 	=	preload("res://particules_2D/sparkle.tscn")
onready var spawn_fire 		= 	preload("res://particules_2D/Fire.tscn")
onready var rotated_gold 	= 	preload("res://characters/Gold.tscn")

var unique = []
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
	
	_load_ressources()
	charger_intro()
	rain_spawn()

func _process(delta):
	pass

	
func charger_intro() :
	
	load_characters()
	var rot_gold = rotated_gold.instance()
	add_child(rot_gold)
#	load_hud()

func load_characters() :
	
	var enemyNode = enemy.instance()
	add_child(enemy.instance())
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
			
	fire_spawn()

	var enemy_pos_comp = ECS.add_component(enemyNode, ComponentsLibrary.Position) as PositionComponent
	
	ECS.add_component(heroNode, ComponentsLibrary.Position)
	ECS.add_component(heroNode, ComponentsLibrary.Movement)
	ECS.add_component(heroNode, ComponentsLibrary.Collision)
	var comp_anim_hero = ECS.add_component(heroNode, ComponentsLibrary.Animation) as AnimationComponent
	var anim_name_hero = {comp_anim_hero.anim.left : "anim_left", comp_anim_hero.anim.right : "anim_right", comp_anim_hero.anim.jump : "anim_jump", comp_anim_hero.anim.idle : "anim_idle"}
	var animation_player_hero = heroNode.get_node("animation_hero")
	comp_anim_hero.init(anim_name_hero, animation_player_hero)
	
	ECS.add_component(monsterNode, ComponentsLibrary.Position)
	var comp_anim_monster = ECS.add_component(monsterNode, ComponentsLibrary.Animation) as AnimationComponent
	var anim_name_monster = {comp_anim_monster.anim.right : "anim_right"}
	var animation_player_monster = monsterNode.get_node("animation_monster")
	print (animation_player_monster)
	comp_anim_monster.init(anim_name_monster, animation_player_monster)
	var comp_patrol = ECS.add_component(monsterNode, ComponentsLibrary.Patrol) as PatrolComponent
	comp_patrol.init(700,900) 
	
	ECS.add_component(EyeNode, ComponentsLibrary.Movement)
	var eye_pos_comp = ECS.add_component(EyeNode, ComponentsLibrary.Position) as PositionComponent
	eye_pos_comp.set_position(enemy_pos_comp.get_position())
	var comp_missile = ECS.add_component(EyeNode, ComponentsLibrary.Missile) as MissileComponent
	comp_missile.init(heroNode)
	
#	ECS.add_component(FireNode, ComponentsLibrary.Movement)
#	var comp_move = ECS.add_component(FireNode, ComponentsLibrary.Movement) as MovementComponent
#	comp_move.line(Vector2)
	
	var hud_comp = ECS.add_component(heroNode, ComponentsLibrary.Hud) as HudComponent
	
	hud_comp.init_hero(HudNode.get_life_hero(),HudNode.get_life_hero_label(), 
	HudNode.get_life_hero_max(), HudNode.get_damage(), 
	HudNode.get_xp(), HudNode.get_level(), HudNode.get_treasure())
	
	var health_comp = ECS.add_component(heroNode, ComponentsLibrary.Health) as HealthComponent
	health_comp.init(100,100)
	
	var treasure_comp = ECS.add_component(heroNode, ComponentsLibrary.Treasure) as TreasureComponent
	treasure_comp.init(0)
	
	var xp_comp = ECS.add_component(heroNode, ComponentsLibrary.Xp) as XpComponent
	xp_comp.init(0)
	
	var damage_comp = ECS.add_component(heroNode, ComponentsLibrary.Damage) as DamageComponent
	damage_comp.init(10)
	
	
func load_hud() :

	var hudd = hud.instance()

	add_child(hudd)
	
	hudd.set_xp(GLOBAL.xp)						# Maj global
	
				#hud Hero
	hudd.set_pv_hero_max(GLOBAL.pv_hero_max)
	hudd.set_pv_hero(GLOBAL.pv_hero)
	
	hudd.set_degats(GLOBAL.degats)
	hudd.set_level(GLOBAL.level)
	hudd.set_treasure(GLOBAL.treasure)
	
	hudd.set_name("hud_hero")
	
func combat(valeur) :
	if valeur == 0 :
		get_tree().change_scene("res://map/map_fight.tscn")
		


func _on_Button_pressed():
	dict ["health"] = GLOBAL.pv_hero
	dict ["health_max"] = GLOBAL.pv_hero_max
	dict["xp"] = GLOBAL.xp
	save_ressources()
	get_tree().change_scene("res://map/Start.tscn")

func treasure_spawn() :
	
	var hero_pos = hero.instance()
	var treasure_pos = hero_pos.get_position()
	print (treasure_pos)
	add_child(treasure.instance())
	treasure.instance().set_position(treasure_pos) 
	var test = treasure.instance().get_position()
	
	var smoke_pos = get_node("monster").get_position()
	var smoke_Node = smoke_spawn.instance()
	add_child(smoke_Node)
	smoke_Node.set_position(smoke_pos) 
	
	var sparkle_pos = get_node("monster").get_position()
	var sparkle_Node = sparkle_spawn.instance()
	add_child(sparkle_Node)
	sparkle_Node.set_position(sparkle_pos) 
	
func fire_spawn():
	
#	var smoke_pos = get_node("hero").get_position()
#	smoke_pos.y += 50
#	var smoke_Node = smoke_spawn.instance()
	var fire_Node = spawn_fire.instance()
	fire_Node.set_position(Vector2(800,400)) 
	add_child(fire_Node)
	
	

func rain_spawn():
	randomize()
	var screen_size = get_viewport().size
	var screen_tile = Vector2(screen_size.x, screen_size.y) / Vector2(64,64)
	
	_unique()
	
	for x in 10 :
		if unique[x] == [1] :
			var x_pos = x
			var i = spawn_rain.instance()
			i.start(Vector2(x_pos * 64 , 0), randi() % 3)
			self.add_child(i)	
	return unique


func _unique():
	for x in 10 :
		unique.append([])
		if randi() % 2 == 1 :
			unique[x].append(1)
		else :
			unique[x].append(0)
	return unique

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

	add_child(spawn_fire.instance())