extends KinematicBody2D

signal spell_enemy_ready(value)

onready var lot   = preload("res://fight/loot_monstre.tscn")

enum spellType {ballfire}
var spells = {}

func _ready():	
	GLOBAL.connect("win", self, "death")
	connect("spell_enemy_ready", get_parent(), "ready_spell")	
		
func death(valeur):
	var pos = self.position
	var i = lot.instance()
	i.start(pos)
#	if boo :
	get_parent().add_child(i)
		
	queue_free()


func add_spell(spellRoot, type):
	spells[type] = spellRoot

func cast_spell(type):
	if (spells.has(type)):
		emit_signal("spell_enemy_ready", 1)
	else:
		print("cast_spell: no spell registered for type " + str(type))


#func _process(delta):
#	pass

