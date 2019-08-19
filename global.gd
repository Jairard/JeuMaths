extends Node

var xp      	= 0
var level   	= 1
var pv_hero_max = 100
var pv_hero     = pv_hero_max
var treasure  	= 0
var degats 		= 1
var pv_ennemy_max = pv_hero_max * 1.1
var pv_ennemy   = pv_ennemy_max
var armure 		= 0

var hero_pos_x = 0
var hero_pos_y = 0
var enemy_pos_x = 0
var enemy_pos_y = 0

enum items {xp,level, pv_hero, pv_ennemy, tresor, armure, life, degats}

signal xp(value)
signal level(value)
signal pv_hero(value)
signal pv_hero_max(value)
signal degats(value)
signal pv_ennemy(value)
signal win(value)
signal treasure(value)
signal death()


func item_loot(type):
	if type == items.xp :
		check_xp()
		

	if type == items.pv_hero :
		pv_hero_max += 10
		xp += 100
		emit_signal("pv_hero_max", pv_hero_max)
		emit_signal("xp", xp)
		check_xp()

	if type == items.degats :
		degats += 10
		xp += 100
		emit_signal("degats", degats)
		emit_signal("xp", xp)
		check_xp()

func end_fight(value):
	
	if value == 0 : 
		pv_ennemy -= 10
		emit_signal("pv_ennemy", pv_ennemy)
		if pv_ennemy <= 1:
			fight_win()
			
	if value == 1 : 
		pv_hero -= 10
		emit_signal("pv_hero", pv_hero)
		if pv_hero == 0 :
			fight_lose()
	
	
	
func fight_lose():
	GLOBAL.pv_hero = GLOBAL.pv_hero_max
	GLOBAL.pv_ennemy_max = GLOBAL.pv_hero_max
	get_tree().change_scene("res://map/map_level.tscn")

func fight_win():
	GLOBAL.pv_hero = GLOBAL.pv_hero_max
	GLOBAL.pv_ennemy_max = GLOBAL.pv_hero_max
	emit_signal("win", 0)

func check_xp():
	xp += 100
	emit_signal("xp", xp)
	if xp >= 100 :
		level += 1
		xp = 0
		emit_signal("xp", xp)
		emit_signal("level", level)
