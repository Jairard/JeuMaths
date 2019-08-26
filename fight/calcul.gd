extends Node2D

signal fight(value)
signal spell_hero(value)
signal spell_enemy(value)

var count = 0

func _ready():
	
#	$Sprite.position = Vector2(350, 400)
#	$Sprite/question/MarginContainer/calcul/Sprite2.position = Vector2(400, 400)
#	$Sprite/question/MarginContainer/calcul/Sprite3.position = Vector2(350, 500)
	
	connect("fight", GLOBAL, "end_fight")
	connect("spell_hero", get_parent(), "throw_spell")
	connect("spell_enemy", get_parent(), "throw_spell")


func _process(delta):
	count += 1

	$Sprite.rotation = count * delta
	$Sprite/question/MarginContainer/calcul/Sprite2.rotation = count * delta
	$Sprite/question/MarginContainer/calcul/Sprite3.rotation = count * delta
	
	
	
func _on_answer_1_pressed():
#	print("perdu")
	emit_signal("fight", 1)
	emit_signal("spell_enemy", 0)
	clean_up()


func _on_answer_2_pressed():
#	print("gagné")
	emit_signal("fight",0)
	emit_signal("spell_hero", 1)
	clean_up()

func clean_up():
	queue_free()


