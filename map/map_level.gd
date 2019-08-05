extends Node2D

onready var enemy = preload("res://characters/Ennemy.tscn")
onready var hero = preload("res://characters/hero.tscn")
onready var hud = preload("res://hud/hud_hero.tscn")
onready var spawn_rain = preload("res://characters/rain.tscn")
onready var rains = preload("res://characters/rain.tscn")

var unique = []
var file = File.new()
var dict = {}
	
func _ready():
	_load_ressources()
	charger_intro()
	rain_spawn()

func _process(delta):
	pass
	

func charger_intro() :
	add_child(enemy.instance())
	add_child(hero.instance())
	
	load_hud()

func load_hud() :

	var hudd = hud.instance()
	add_child(hudd)
	
	hudd.set_xp(GLOBAL.xp)						# Maj global
	
				#hud Hero
	hudd.set_pv_hero_max(GLOBAL.pv_hero_max)
	hudd.set_pv_hero(GLOBAL.pv_hero)
	
	hudd.set_degats(GLOBAL.degats)
	hudd.set_level(GLOBAL.level)
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
	file.close()
	
func save_ressources():
	file.open("res://log_in/pseudo.json", File.WRITE)
	var health = to_json(dict)
	file.store_string(health)
	file.close()
	
	
	
	
	
	