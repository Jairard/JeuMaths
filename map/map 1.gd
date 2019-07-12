extends Node2D

signal fight(value)

var sec = 4 


onready var hero   = preload("res://characters/hero.tscn")
onready var enemy = preload("res://characters/Ennemy.tscn")
onready var hud    = preload("res://hud/hud_hero.tscn")
onready var hud_pro    = preload("res://hud/hud_enemy.tscn")
onready var spell = preload("res://fight/animationsort.tscn")
onready var calcul = preload("res://fight/calcul.tscn")
onready var time_label = get_node("sol/time_label")
onready var game_timer = get_node("game_timer")

# Each call of instance() create a new object
# Here we only want one of them so we store it in a variable
onready var heroRoot = hero.instance()

func _ready():
	connect("fight", GLOBAL, "end_fight")	
	spawn()

func _process(delta):
	time_label.set_text(str(int(game_timer.get_time_left())))
	
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
	
	var hudd = hud.instance()
	add_child(hudd)
	
	hudd.set_pv_hero(GLOBAL.pv_hero)				#hud Hero
	hudd.set_degats(GLOBAL.degats)
	hudd.set_xp(GLOBAL.xp)
	hudd.set_level(GLOBAL.level)
	
	var huddd = hud_pro.instance()
	add_child(huddd)

	huddd.set_pv_ennemy(GLOBAL.pv_ennemy)		#hud Enemy
	
	
	

func combat(valeur):
	pass


func _on_game_timer_timeout():
	sec -= 4
	if sec == 0 :
		print ("test")
		time_label.hide()
		add_child(calcul.instance())

func _on_return_pressed():
	print ("test")
	get_tree().change_scene("res://map/map_level.tscn")
