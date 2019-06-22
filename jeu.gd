extends Node2D

var xp = 0
var level = 1
# warning-ignore:unused_class_variable
var pv = 100
var tresor = 0




func _ready():			
								# if monstre tue xp + 20	
									#ennemi_kill(20, 10, "  ")
								# if boss tue  xp + 50
									#ennemi_kill(50, 30, "  ")
	#match type_loot:
		#if 
	#ennemi_kill(200, 10, "epee")
	pass 

# warning-ignore:unused_argument
func recup_loot(valeur):
	#print("item recupere : " + str(valeur))
	ennemi_kill(200,200,200)
	


# warning-ignore:unused_argument
#func _process(delta):
#	pass



# warning-ignore:unused_argument
func ennemi_kill(gain_xp, piece_or, loot):		
	xp += gain_xp				
	tresor += piece_or
	if xp >= 100 : 
		xp = 0
		level += 1
		pv += 10
	
	print ("Xp : " + str (xp), "  Level : " + str(level), "  Trésor : " + str(tresor), " Loot : " + str(loot), "  Pv : " + str(pv))
	

func combat(valeur) :
	
	if valeur == 0 : 
		print ("le combat commence")
		get_tree().change_scene("res://map/map 1.tscn")
		pass
	else : 
		pass
	