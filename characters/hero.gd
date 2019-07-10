extends KinematicBody2D

var xp = 0
var level = 1
var pv = 100
var tresor = 0

var inventaire = [null,null]

# We use an enum so that we can easily add more spells
enum spellType {fireball}
# This variable is a dictionary that gives, for each type of spell,
# the variable that allows use to spawn the spell.
# By default, out hero has no spell so its dictionary is empty
var spells = {} # empty dictionary

export(int) var vitesse = 200
var velocite = Vector2(0,0)

signal comb(valeur)

func _ready():
	self.connect("comb", get_parent(), 'combat')


func _process(delta):
	velocite = Vector2(0,0)

	if Input.is_action_pressed("ui_down") :
		if !$RayCast_bas.is_colliding(): 
			velocite.y += vitesse
			$"animation hero".play("mouvement bas")
		else : 
			emit_signal('comb', 0)

	elif Input.is_action_pressed("ui_left") :
		if !$RayCast_gauche.is_colliding(): 
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

func add_spell(spellRoot, type):
	# Store the spell in the dictionary
	# For now, we don't need to spawn it
	spells[type] = spellRoot

func cast_spell(type):
	# Check if the hero has a spell for this type
	if (spells.has(type)):
		# If it does, we instantiate it
		var spell = spells[type].instance() #we create a node animationsort.tscn
		# Add the spell as a child
		# FIXME this is not a good idea since the spell will move with the hero
		add_child(spell)
		# Cast it
		spell.cast()
	else:
		print("cast_spell: no spell registered for type " + str(type))

