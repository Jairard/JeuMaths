extends Node2D

signal fight(value)


func _ready():
	connect("fight", GLOBAL, "end_fight")
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_answer_1_pressed():
#	print("perdu")
	emit_signal("fight", 1)


func _on_answer_2_pressed():
#	print("gagné")
	emit_signal("fight",0)




