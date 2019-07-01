extends Node2D

onready var hero   = preload("res://hero.tscn")
onready var ennemy = preload("res://Ennemy.tscn")
onready var sort   = preload("res://animationsort.tscn")
onready var loot   = preload("res://loot_monstre.tscn")
#onready var hud    = preload("res://Hud.tscn")
onready var hud    = preload("res://hudpro.tscn")


#hero.add_spell
# methode dans hero qui prenne le noeud de l'animation
#add_spell(node2d)
#add_child a la position du hero
func _ready():
	spawn()
	pass


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"	):
		var s = sort.instance()
		s.sort(self.position)
		add_child(s)
		


		var pos = self.position
		var i = loot.instance()
		var boo = i.start(pos)
		if boo :
			add_child(i)
			i.connect("loot", GLOBAL, "item_loot")
#	pass


func spawn() :
	add_child(hero.instance())
	add_child(ennemy.instance())
	add_child(hud.instance())
	re_size()
	

func re_size():
	print("resize")


func _on_Button_pressed():
	get_tree().change_scene("res://map/map 0.tscn")
	pass # Replace with function body.


func sort(positio : Vector2):
#	print(positio)
	pass
	
	