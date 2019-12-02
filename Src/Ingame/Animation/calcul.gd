extends Node2D

var count = 0
var answer_listeners  : Array = []


func set_answer_listener(listeners : Array) -> void:
	answer_listeners  = listeners
	
func _ready():
	pass

func _process(delta):
	count += 1

#	$ans_1.rotation = count * delta
#	$ans_2.rotation = count * delta
	pass
	
	
func _on_answer_1_pressed():
	for listener in answer_listeners:
		var component : AnswerListenerComponent = listener as AnswerListenerComponent
		if component != null:	
			component.set_answer(AnswerListenerComponent.answer.false)	
#			print (component.get_answer())	

#	clean_up()


func _on_answer_2_pressed():
	for listener in answer_listeners:
		var component : AnswerListenerComponent = listener as AnswerListenerComponent 	# object which is AnswerListenercomponent 
		if component != null:
			component.set_answer(AnswerListenerComponent.answer.true)
#			print (component.get_answer())	

			
#	clean_up()

func clean_up():
	queue_free()

