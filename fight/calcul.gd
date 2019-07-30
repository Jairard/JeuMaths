extends Node2D

signal fight(value)
signal spell_hero(value)
signal spell_enemy(value)

func _ready():
	connect("fight", GLOBAL, "end_fight")
	connect("spell_hero", get_parent(), "throw_spell")
	connect("spell_enemy", get_parent(), "throw_spell")
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_answer_1_pressed():
#	print("perdu")
	emit_signal("fight", 1)
	emit_signal("spell_enemy", 0)


func _on_answer_2_pressed():
#	print("gagné")
	emit_signal("fight",0)
	emit_signal("spell_hero", 1)

func clean_up(value):
	if value == 0 :
		print ("test")
		queue_free()


