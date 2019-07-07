extends Node

var xp      	= 0
var level   	= 1
var pv_hero     = 100
var tresor  	= 0
var degats 		= 1
var pv_ennemy   = 100
var armure 		= 0

enum items {xp,level, pv_hero, pv_ennemy, tresor, armure, life, degats}

signal refreshloot(type, value)
signal win(value)

func item_loot(type):
	if type == items.xp :
		xp += 40
		emit_signal("refreshloot", items.xp, xp)
#		print ("xp : " + str(xp))
		if xp >= 100 :
			level += 1
			xp = 0
			emit_signal("refreshloot", items.xp, xp)
			emit_signal("refreshloot", items.level, level)
#			print ("level : " + str(level))

	if type == items.pv_hero :
		pv_hero -= 10
		emit_signal("refreshloot", items.pv_hero, pv_hero)
#		print ("pv : " + str(pv_hero))
		if pv_hero == 0 :
			fight_lose()

	if type == items.pv_ennemy :
		pv_ennemy -= 10
		emit_signal("refreshloot", items.pv_ennemy, pv_ennemy)
#		print ("pv_ennemy : " + str(pv_ennemy))
		if pv_ennemy == 0:
			fight_win()

	if type == items.degats :
		degats += 10
		emit_signal("refreshloot", items.degats, degats)
#		print ("degats : " + str(degats))

func fight_lose():
	get_tree().change_scene("res://map/map 0.tscn")

func fight_win():
	emit_signal("win", 0)
