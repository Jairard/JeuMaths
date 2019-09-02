extends KinematicBody2D

#var inventaire = [null,null]

# We use an enum so that we can easily add more spells
#enum spellType {fireball}
# This variable is a dictionary that gives, for each type of spell,
# the variable that allows use to spawn the spell.
# By default, out hero has no spell so its dictionary is empty
#var spells = {} # empty dictionary

#const gravity = 1300
#export(int) var vitesse = 250
#var velocity = Vector2()
#var moving = false

#signal comb(valeur)
#signal spell_ready(value)
#signal spawn_treasure()

func _ready():
	
	self.position = Vector2(100, 50)
#	$hero_coll.position = self.position
#	self.connect("comb", get_parent(), 'combat')
#	connect("spell_ready", get_parent(), "ready_spell")	
#	connect("spawn_treasure", get_parent(), "treasure_spawn")
#	$CollisionShape2D.set_name("hero_coll")

	
func _physics_process(delta):				# 60 ticks / sec whatever fps

#	velocity.x = 0
#	velocity.y += gravity * delta 
	
#	move()

#	move_and_slide(velocity)


	
#	detect_monster()
	pass
#func move():

##	var MoveComponent = ECS.__get_component(get_instance_id(), ComponentsLibrary.Movement)  as MovementComponent
##
##	if MoveComponent.is_moving() :
#
	


#func detect_monster():
#	if $RayCast_bas.is_colliding() :
#		moving = true
#		velocite.y = - 350
#		$"animation hero".play("mouvement haut")
#		GLOBAL.emit_signal("treasure",GLOBAL.treasure)
#		emit_signal("spawn_treasure")
#		GLOBAL.emit_signal("death")


#func recup_loot(value):
#
#	if value == 0 :
#		bonus_health()
#
#	if value == 1 :
#		malus_health()
#
#	if value == 2 :
#		bonus_or()
#
#
#func bonus_health():
#
#	if GLOBAL.pv_hero == GLOBAL.pv_hero_max :
#
#		GLOBAL.pv_hero_max += 10
#		GLOBAL.pv_hero += 10
#
#		GLOBAL.emit_signal("pv_hero_max",GLOBAL.pv_hero_max)
#		GLOBAL.emit_signal("pv_hero",GLOBAL.pv_hero)
#
#	if GLOBAL.pv_hero < GLOBAL.pv_hero_max :
#
#		GLOBAL.pv_hero += 10
#		GLOBAL.emit_signal("pv_hero",GLOBAL.pv_hero)
#
#
#func malus_health():
#
#	GLOBAL.pv_hero -= 10
#
#	GLOBAL.emit_signal("pv_hero",GLOBAL.pv_hero)
#
#
#func bonus_or():
#	GLOBAL.treasure += 1
#	GLOBAL.emit_signal("treasure", GLOBAL.treasure)
#
#
#func add_spell(spellRoot, type):
#	# Store the spell in the dictionary
#	# For now, we don't need to spawn it
#	spells[type] = spellRoot
#
#func cast_spell(type):
#	# Check if the hero has a spell for this type
#	if (spells.has(type)):
#		# If it does, we instantiate it
##		var spell = spells[type].instance() #we create a node animationsort.tscn
##		# Add the spell as a child
##		# FIXME this is not a good idea since the spell will move with the hero
##		add_child(spell)
##		# Cast it
##		spell.cast()
#		emit_signal("spell_ready", 0)
#	else:
#		print("cast_spell: no spell registered for type " + str(type))
#
