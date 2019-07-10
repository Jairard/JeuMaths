extends Node2D

signal fight(value)

onready var hero   = preload("res://characters/hero.tscn")
onready var enemy = preload("res://characters/Ennemy.tscn")
#onready var loot   = preload("res://fight/loot_monstre.tscn")
onready var hud    = preload("res://hud/hud_fight.tscn")
# We load the spelle here so that we can inject it into hero
onready var spell = preload("res://fight/animationsort.tscn")

# Each call of instance() create a new object
# Here we only want one of them so we store it in a variable
onready var heroRoot = hero.instance()

func _ready():
	connect("fight", GLOBAL, "end_fight")	
	spawn()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		heroRoot.cast_spell(heroRoot.spellType.fireball)
		emit_signal("fight",0)


func spawn() :
	# Inject hero into map
	add_child(heroRoot)
	# Register the fireball spell
	heroRoot.add_spell(spell, heroRoot.spellType.fireball)
	add_child(enemy.instance())
	
	var sprite = $Ennemy/Sprite # Or enemy.instance().get_node("Sprite")
	sprite.apply_scale(Vector2(3, 3)) # Multiply scale by 2 on both X and Y axis
	$Ennemy/CollisionShape2D.scale = Vector2(3, 3)
	
	var huddd = hud.instance()
	add_child(huddd)
	huddd.set_pv_ennemy(GLOBAL.pv_ennemy)
	huddd.set_pv_hero(GLOBAL.pv_hero)
	huddd.set_degats(GLOBAL.degats)
	huddd.set_xp(GLOBAL.xp)
	huddd.set_level(GLOBAL.level)
	

func _on_return_pressed():
	get_tree().change_scene("res://map/map 0.tscn")

func combat(valeur):
	pass

func _on_ready_pressed():
	$sol/ready.hide()
	$sol/calcul.show()
	$sol/answer_1.show()
	$sol/answer_2.show()

func _on_answer_1_pressed():
	print ("gagné")


func _on_answer_2_pressed():
	print ("perdu")

