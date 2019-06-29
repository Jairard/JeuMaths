extends Node

var xp      = 0
var level   = 1
var pv      = 10
var tresor  = 0
var degats  = 1
var life    = 0
var armure = 0

enum items {xp,level, pv, tresor, armure, life, degats}


signal refreshloot(type, value)

func _ready():
	pass 
		
	
	
#func _process(delta):
#	pass


func item_loot(type):
#	print (type)
	if type == 0 : 
		xp += 10
		emit_signal("refreshloot", "xp" , xp)
		print ("xp : " + str(xp))
		if xp == 100 :
			level += 1
			xp = 0
			emit_signal("refreshloot", "xp" , xp)
			emit_signal("refreshloot", "level" , level)
			print ("level : " + str(level))
	if type == 2 :
		pv += 10
		emit_signal("refreshloot", "pv" , pv)
		print ("pv : " + str(pv))
#	if type == 4 :
#		armure += 1
#		emit_signal("refreshloot", "armure" , armure)
#		print ("armure : " + str(armure))
	if type == 6 : 
		degats += 10
		emit_signal("refreshloot", "degats" , degats)
		print ("degats : " + str(degats))