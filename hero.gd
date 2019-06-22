extends KinematicBody2D

onready var sort = preload("res://animation sort.tscn")


export(int) var vitesse = 200
var velocite = Vector2(0,0)

signal comb(valeur)

func _ready():
# warning-ignore:return_value_discarded
	self.connect("comb", get_parent(), 'combat')
	pass 


# warning-ignore:unused_argument
func _process(delta):
	velocite = Vector2(0,0)
	
	if Input.is_action_pressed("ui_down") :
		if !$RayCast_bas.is_colliding() : #== false :
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
			print("77777777777777777777777")
		
	
	velocite = move_and_slide(velocite).normalized()
	
