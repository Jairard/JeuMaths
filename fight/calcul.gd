extends Node2D

var count = 0

func _ready():
	pass


func _process(delta):
	count += 1

	$Sprite.rotation = count * delta
	$Sprite/question/MarginContainer/calcul/Sprite2.rotation = count * delta
	$Sprite/question/MarginContainer/calcul/Sprite3.rotation = count * delta
	
	
func _on_answer_1_pressed():
	print("lose")
	clean_up()


func _on_answer_2_pressed():
	print("win")
	clean_up()

func clean_up():
	queue_free()


