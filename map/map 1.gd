extends Node2D

onready var hero   = preload("res://characters/hero.tscn")
onready var enemy = preload("res://characters/Ennemy.tscn")
onready var loot   = preload("res://fight/loot_monstre.tscn")
onready var hud    = preload("res://hud/hudpro.tscn")

func _ready():
	spawn()
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"	):
		get_node("hero").add_spell()

		var pos = self.position
		var i = loot.instance()
		var boo = i.start(pos)
		if boo :
			add_child(i)
			i.connect("loot", GLOBAL, "item_loot")

func spawn() :
	add_child(hero.instance())
	add_child(enemy.instance())
	add_child(hud.instance())
	re_size()
	var sprite = $Ennemy/Sprite # Or enemy.instance().get_node("Sprite")
	sprite.apply_scale(Vector2(2, 2)) # Multiply scale by 2 on both X and Y axis

func re_size():
	print("resize")

func _on_Button_pressed():
	get_tree().change_scene("res://map/map 0.tscn")
