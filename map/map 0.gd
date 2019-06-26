extends Node2D

var xp = 0
var level = 1
# warning-ignore:unused_class_variable
var pv = 100
var tresor = 0


onready var ennemy = preload("res://ennemy.tscn")
onready var hero = preload("res://hero.tscn")
onready var coin = preload("res://coin.tscn")
#onready var enemi = preload("res://ennemi.tscn")

func _ready():
	charger_intro()

	


#func _process(delta):
#	pass

func charger_intro() :
	print ("2222222222222222222222222")
	add_child(ennemy.instance())
	add_child(hero.instance())
	add_child(coin.instance())
	

func combat(valeur) :
	if valeur == 0 :
		var ret = get_tree().change_scene("res://map/map 1.tscn")
		
func recup_loot(valeur):
	#print("item recupere : " + str(valeur))
	ennemi_kill(200,200,200)
	
func ennemi_kill(gain_xp, piece_or, loot):		
	xp += gain_xp				
	tresor += piece_or
	if xp >= 100 : 
		xp = 0
		level += 1
		pv += 10
	
	print ("Xp : " + str (xp), "  Level : " + str(level), "  Trésor : " + str(tresor), " Loot : " + str(loot), "  Pv : " + str(pv))
	
