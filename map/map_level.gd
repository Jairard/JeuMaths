extends Node2D

onready var enemy = preload("res://characters/Ennemy.tscn")
onready var hero = preload("res://characters/hero.tscn")
onready var hud = preload("res://hud/hud_hero.tscn")
onready var spawn_rain = preload("res://characters/rain.tscn")
onready var rains = preload("res://characters/rain.tscn")
onready var _eye = preload("res://characters/eye.tscn")
onready var monster = preload("res://characters/monsters.tscn")
onready var treasure = preload("res://characters/treasure.tscn")
onready var smoke_spawn = preload("res://particules_2D/smoke_2.tscn")
onready var sparkle_spawn =preload("res://particules_2D/sparkle.tscn")
onready var spawn_fire = preload("res://particules_2D/Fire.tscn")

var unique = []
var file = File.new()
var dict = {}
	
func _ready():
	ECS.register_system(SystemsLibrary.Move)
	ECS.register_system(SystemsLibrary.Input)
	ECS.register_system(SystemsLibrary.Animation)
	ECS.register_system(SystemsLibrary.Collision)
#	_load_ressources()
	charger_intro()
	rain_spawn()

func _process(delta):
	pass

	
func charger_intro() :

	load_characters()
	load_hud()

func load_characters() :
	
	var enemyNode = enemy.instance()
	add_child(enemy.instance())
	enemyNode.set_name("enemy")
	
	add_child(_eye.instance())
	add_child(enemy.instance())
	
	var heroNode = hero.instance()
	add_child(heroNode)
	heroNode.set_name("hero")

	
	var monsterNode = monster.instance()
	add_child(monsterNode)
	monsterNode.set_name("monster")
	
	particules_spawn_monster()
	particules_spawn_hero()	
	
	ECS.add_component(heroNode, ComponentsLibrary.Position)
	ECS.add_component(heroNode, ComponentsLibrary.Movement)
	ECS.add_component(heroNode, ComponentsLibrary.Collision)
	ECS.add_component(enemyNode, ComponentsLibrary.Position)
	ECS.add_component(enemyNode, ComponentsLibrary.Movement)
	ECS.add_component(enemyNode, ComponentsLibrary.Collision)
	
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
	dict["treasure"] = GLOBAL.treasure
#	save_ressources()
	get_tree().change_scene("res://map/Start.tscn")

func treasure_spawn() :
	
	var treasure_pos = get_node("monster").get_position()
	var treasureNode = treasure.instance()
	add_child(treasureNode)
	treasureNode.set_position(treasure_pos) 
	
func particules_spawn_monster():
	
	var smoke_pos = get_node("monster").get_position()
	var smoke_Node = smoke_spawn.instance()
	add_child(smoke_Node)
	smoke_Node.set_position(smoke_pos) 
	
	var sparkle_pos = get_node("monster").get_position()
	var sparkle_Node = sparkle_spawn.instance()
	add_child(sparkle_Node)
	sparkle_Node.set_position(sparkle_pos) 
	
func particules_spawn_hero():
	
	var smoke_pos = get_node("hero").get_position()
#	var smoke_Node = smoke_spawn.instance()
	var fire_Node = spawn_fire.instance()
	add_child(fire_Node)
	fire_Node.set_position(smoke_pos) 
	
	var sparkle_pos = get_node("hero").get_position()
	var fireNode = spawn_fire.instance()
	add_child(fireNode)
	fireNode.set_position(sparkle_pos) 
 
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
	
	file.open("res://log_in/pseudo.json", File.READ)
	dict = parse_json(file.get_as_text())
	GLOBAL.pv_hero_max = dict["health_max"]
	GLOBAL.pv_hero = dict["health"]
	GLOBAL.xp = dict["xp"]
	GLOBAL.treasure = dict["treasure"]
	file.close()
	
func save_ressources():
	file.open("res://log_in/pseudo.json", File.WRITE)
	var value = to_json(dict)
#	dict["treasure"] = GLOBAL.treasure
#	file.store_var(dict["treasure"])
#	var treasure = to_json(dict)
#	file.store_string(treasure)
	file.close()
	
func _on_Timer_timeout():

	add_child(_eye.instance())
