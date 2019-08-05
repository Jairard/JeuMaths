extends Node2D


var sec = 4 

onready var hero   = preload("res://characters/hero.tscn")
onready var enemy = preload("res://characters/Ennemy.tscn")
onready var hud    = preload("res://hud/hud_hero.tscn")
onready var hud_pro    = preload("res://hud/hud_enemy.tscn")
onready var spell = preload("res://fight/test_spell.tscn")
onready var spell_enemy = preload("res://fight/spell_enemy.tscn")
onready var calcul = preload("res://fight/calcul.tscn")

onready var time_label = get_node("sol/time_label")
onready var game_timer = get_node("game_timer")

onready var heroRoot = hero.instance()
onready var enemyRoot = enemy.instance()

onready var right = 0
onready var wrong = 0
onready var test = 0
onready var test2 = 0
# Register the fireball spell
func _ready():
	spawn()

func _process(delta):
	time_label.set_text(str(int(game_timer.get_time_left())))
	
	if right == 1 : 
#		print ("right") 
		var pos = heroRoot.get_position()
		print (pos)
		if pos.x <= enemyRoot.get_position().x :
			pos.x += 10
			heroRoot.set_position(pos)
		else: 
			right = 0
		
	if wrong == 1 :
#		print ("wrong")
		wrong = 0
		
#	velocite = get_node(spell).move_and_collide(velocite)
#	connect("spell_hero", self, "hero_spell")
	
#	if Input.is_action_just_pressed("ui_accept"):
#		heroRoot.cast_spell(heroRoot.spellType.fireball)


func spawn() :
	# Inject hero into map
	
	add_child(heroRoot)
	add_child(enemyRoot)
	
#	# Register the fireball spell
	heroRoot.add_spell(spell, heroRoot.spellType.fireball)
	enemyRoot.add_spell(spell, enemyRoot.spellType.ballfire)

	GLOBAL.hero_pos_x = heroRoot.position.x
	GLOBAL.hero_pos_y = heroRoot.position.y
	GLOBAL.enemy_pos_x = enemyRoot.position.x
	GLOBAL.enemy_pos_y = enemyRoot.position.y
	enemyRoot.set_position(Vector2(750,350))
	
	var sprite = $Ennemy/Sprite # Or enemy.instance().get_node("Sprite")
	sprite.apply_scale(Vector2(4, 4)) # Multiply scale by 2 on both X and Y axis
	$Ennemy/CollisionShape2D.scale = Vector2(4, 4)
	
	var hudd = hud.instance()
	add_child(hudd)
	
	GLOBAL.pv_hero = GLOBAL.pv_hero_max					#init pv_hero to that max value
	
	hudd.set_pv_hero_max(GLOBAL.pv_hero_max)
	hudd.set_pv_hero(GLOBAL.pv_hero_max)				#hud Hero
	
	hudd.set_degats(GLOBAL.degats)
	hudd.set_xp(GLOBAL.xp)
	hudd.set_level(GLOBAL.level)
	
	var huddd = hud_pro.instance()
	add_child(huddd)

	GLOBAL.pv_ennemy_max = GLOBAL.pv_hero_max * 1.5			#init pv_ennemy to pv_hero_max x 1.1
	GLOBAL.pv_ennemy = GLOBAL.pv_ennemy_max
	huddd.set_pv_ennemy(GLOBAL.pv_ennemy_max)				#hud Enemy
	huddd.set_pv_ennemy_max(GLOBAL.pv_ennemy_max)


func throw_spell(value):
	if value == 0 :
		heroRoot.cast_spell(heroRoot.spellType.fireball)	
	if value == 1 :
		enemyRoot.cast_spell(enemyRoot.spellType.ballfire)	

func combat(valeur):
	pass


func _on_game_timer_timeout():
	sec -= 4
	if sec == 0 :
		time_label.hide()
		add_child(calcul.instance())

func _on_return_pressed():
	get_tree().change_scene("res://map/map_level.tscn")
	
	
func ready_spell(value):
	if value == 1 : 
		test = spell.instance()
		test.position.x = heroRoot.position.x + 70
		test.position.y = heroRoot.position.y
		add_child(test)
#		test.cast()
		right = 1
	if value == 0 : 
		test2 = spell_enemy.instance()
		test2.position.x = enemyRoot.position.x - 150
		test2.position.y = enemyRoot.position.y
		add_child(test2)
#		test2.cast()
		wrong = 1
		

