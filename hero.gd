extends KinematicBody2D

var xp = 0
var level = 1
var pv = 100
var tresor = 0

var inventaire = [null,null]

onready var sort = preload("res://animation sort.tscn")


export(int) var vitesse = 200
var velocite = Vector2(0,0)

signal comb(valeur)
signal damage(valeur)


func _ready():
# warning-ignore:return_value_discarded
	self.connect("comb", get_parent(), 'combat')
	self.connect("damage", get_parent().get_node("Ennemy"), 'death')
	pass 


# warning-ignore:unused_argument
func _process(delta):
	velocite = Vector2(0,0)
	
	if Input.is_action_pressed("ui_down") :
		if !$RayCast_bas.is_colliding(): #== false : 
			velocite.y += vitesse
			$"animation hero".play("mouvement bas")
		else : 
			emit_signal('comb', 0)
			
	elif Input.is_action_pressed("ui_left") :
		if !$RayCast_gauche.is_colliding(): #== false :
			velocite.x -= vitesse
			$"animation hero".play("mouvement gauche")
		else : 
			emit_signal('comb', 0)
			
	elif Input.is_action_pressed("ui_up") :
		if $RayCast_haut.is_colliding() == false :
			velocite.y -= vitesse
			$"animation hero".play("mouvement haut")
		else : 
			emit_signal('comb', 0)
			
	elif Input.is_action_pressed("ui_right") :
		if $RayCast_droite.is_colliding() == false :
			velocite.x += vitesse
			$"animation hero".play("mouvement droite")
		else : 
			emit_signal('comb', 0)
	
	else :
		$"animation hero".play("saut")
		
	if Input.is_action_just_pressed("ui_accept"	):
		var s = sort.instance()
		s.sort(self.position)
		get_parent().add_child(s)
		if $RayCast_droite.is_colliding() == true :
			emit_signal("damage",0)
		
	
	velocite = move_and_slide(velocite).normalized()
	
func recup_loot(valeur):
	print("item recupere : " + str(valeur))
	if valeur == 0 :
		inventaire[0] = "armure"
	if valeur == 1 :
		inventaire[1] = "piece d'or"
	print ("inventaire 1 : ", inventaire[0])
	print ("inventaire 2 : ", inventaire[1])
	ennemi_kill(200,200,200)
	
func ennemi_kill(gain_xp, piece_or, loot):		
	xp += gain_xp				
	tresor += piece_or
	if xp >= 100 : 
		xp = 0
		level += 1
		pv += 10
	
	print ("Xp : " + str (xp), "  Level : " + str(level), "  Trésor : " + str(tresor), " Loot : " + str(loot), "  Pv : " + str(pv))
	

	
