extends Node2D


onready var enemy = preload("res://characters/Ennemy.tscn")
onready var hero = preload("res://characters/hero.tscn")
onready var coin = preload("res://coin.tscn")
onready var hud = preload("res://hud/hudpro.tscn")

func _ready():
	charger_intro()

	

#func _process(delta):
#	pass

func charger_intro() :
	add_child(enemy.instance())
	add_child(hero.instance())
	add_child(coin.instance())
	var hudd = hud.instance()
	add_child(hudd)
	hudd.set_xp(GLOBAL.xp)
	hudd.set_pv_hero(GLOBAL.pv_hero)
	hudd.set_degats(GLOBAL.degats)
	hudd.set_level(GLOBAL.level)
	

func combat(valeur) :
	if valeur == 0 :
		get_tree().change_scene("res://map/map 1.tscn")
		


func _on_Button_pressed():
	get_tree().change_scene("res://map/start.tscn")
