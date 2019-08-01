extends Node2D

onready var enemy = preload("res://characters/Ennemy.tscn")
onready var hero = preload("res://characters/hero.tscn")
#onready var coin = preload("res://coin.tscn")
onready var hud = preload("res://hud/hud_hero.tscn")
onready var spawn_rain = preload("res://characters/rain.tscn")


func _ready():
	charger_intro()
	rain_spawn()

#func _process(delta):
#	pass

func charger_intro() :
	add_child(enemy.instance())
	add_child(hero.instance())
#	add_child(coin.instance())
	
	var hudd = hud.instance()
	add_child(hudd)
	
	hudd.set_xp(GLOBAL.xp)						# Maj global
	hudd.set_pv_hero(GLOBAL.pv_hero_max)
	GLOBAL.pv_hero = GLOBAL.pv_hero_max
	hudd.set_pv_hero_max(GLOBAL.pv_hero_max)
	hudd.set_degats(GLOBAL.degats)
	hudd.set_level(GLOBAL.level)


func combat(valeur) :
	if valeur == 0 :
		get_tree().change_scene("res://map/map_fight.tscn")
		


func _on_Button_pressed():
	get_tree().change_scene("res://map/start.tscn")

func rain_spawn():
	randomize()
	var screen_size = get_viewport().size
	print (screen_size)
	var screen_tile = Vector2(screen_size.x, screen_size.y) / Vector2(64,64)
	
	for x in 15 :
		var x_pos = randi() % 14
		var i = spawn_rain.instance()
		i.start(Vector2(x_pos * 64 , 0), randi() % 3)
		self.add_child(i)

	
	
	
	
	
	
	
	
	
	
	
	