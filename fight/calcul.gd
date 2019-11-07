extends Node2D

var count = 0
var answer_listeners_hero  : Array = []
var answer_listeners_enemy : Array = []

func set_answer_listener(listeners_hero : Array, listeners_enemy : Array) -> void:
	answer_listeners_hero  = listeners_hero
	answer_listeners_enemy = listeners_enemy
	
func _ready():
	pass

func _process(delta):
	count += 1

#	$ans_1.rotation = count * delta
#	$ans_2.rotation = count * delta
	pass
	
	
func _on_answer_1_pressed():
	print("lose")
	for listener in answer_listeners_hero:
		var component : AnswerListenerComponent = listener as AnswerListenerComponent
		if component != null:	
			component.set_answer(AnswerListenerComponent.answer.false)			
	for listener in answer_listeners_hero:
		var emit_component : EmitParticulesComponent = listener as EmitParticulesComponent   
		if emit_component != null:
			emit_component.set_emit(true)
#	clean_up()


func _on_answer_2_pressed():
	print("win")
	for listener in answer_listeners_enemy:
		var component : AnswerListenerComponent = listener as AnswerListenerComponent 	# object which is AnswerListenercomponent 
		if component != null:
			component.set_answer(AnswerListenerComponent.answer.true)
	for listener in answer_listeners_enemy:
		var emit_component : EmitParticulesComponent = listener as EmitParticulesComponent   
		if emit_component != null:
			emit_component.set_emit(true)
			
	# component particules2D emit = true
#	clean_up()

func clean_up():
	queue_free()


