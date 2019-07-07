extends Node2D

onready var hero   = preload("res://characters/hero.tscn")
onready var enemy = preload("res://characters/Ennemy.tscn")
onready var loot   = preload("res://fight/loot_monstre.tscn")
onready var hud    = preload("res://hud/hud_fight.tscn")
# We load the spelle here so that we can inject it into hero
onready var spell = preload("res://fight/animationsort.tscn")

# Each call of instance() create a new object
# Here we only want one of them so we store it in a variable
onready var heroRoot = hero.instance()

func _ready():
	spawn()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		heroRoot.cast_spell(heroRoot.spellType.fireball)
		var pos = self.position
		var i = loot.instance()
		var boo = i.start(pos)
		if boo :
			add_child(i)
			i.connect("loot", GLOBAL, "item_loot")

func spawn() :
	# Inject hero into map
	add_child(heroRoot)
	# Register the fireball spell
	heroRoot.add_spell(spell, heroRoot.spellType.fireball)

	add_child(enemy.instance())
	add_child(hud.instance())
	var sprite = $Ennemy/Sprite # Or enemy.instance().get_node("Sprite")
	sprite.apply_scale(Vector2(3, 3)) # Multiply scale by 2 on both X and Y axis
	$Ennemy/CollisionShape2D.scale = Vector2(3, 3)

func _on_Button_pressed():
	get_tree().change_scene("res://map/map 0.tscn")

func combat(valeur):
	pass