extends Node2D

var count = 0
var answer_listeners : Array = []

func set_answer_listener(listeners : Array) -> void:
	answer_listeners = listeners

func _ready():
	pass

func _process(delta):
#	count += 1
#
#	$Sprite.rotation = count * delta
#	$Sprite/question/MarginContainer/calcul/Sprite2.rotation = count * delta
#	$Sprite/question/MarginContainer/calcul/Sprite3.rotation = count * delta
	pass
	
	
func _on_answer_1_pressed():
	print("lose")
	for listener in answer_listeners:
		var component : AnswerListenerComponent = listener as AnswerListenerComponent   # object which is AnswerListenercomponent 
		if component != null:				
			component.set_answer(AnswerListenerComponent.answer.false)
#	clean_up()


func _on_answer_2_pressed():
	print("win")
	for listener in answer_listeners:
		var component : AnswerListenerComponent = listener as AnswerListenerComponent
		if component != null:
			component.set_answer(AnswerListenerComponent.answer.true)
#	clean_up()

func clean_up():
	queue_free()


