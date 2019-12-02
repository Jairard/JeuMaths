extends Node2D

var count = 0
var answer_listeners  : Array = []
var load_calcul1 = load_c("res://Assets/Questions/calcul1.json")

func set_answer_listener(listeners : Array) -> void:
	answer_listeners  = listeners
	
func load_c(path : String) -> Dictionary:
	var file = File.new()
	file.open(path, File.READ)
	print (file.get_as_text())
	var text = "{\"question\" : \"1 + 1\", \"answers\" : [{\"text\" : \"1\",\"is_good_answer\" : false},{\"text\" : \"2\",\"is_good_answer\" : true}] }"
	var dict = parse_json(text)
	file.close()
	return dict
	
func setup_question(dict : Dictionary) -> void:
	$question/MarginContainer/calcul.text = dict["question"]
	var answers : Array = dict["answers"]
	var ans_position : Vector2 = Vector2(0,100) 
	for ans in answers:
		var button : Button = Button.new() 
		button.text = ans["text"]
		ans_position.x += 50
		button.set_position(ans_position)
		add_child(button)
		button.connect("pressed", self, "on_answer_pressed", [ans["is_good_answer"]])
		

func _ready():
	
	setup_question(load_calcul1)

func _process(delta):
	count += 1

#	$ans_1.rotation = count * delta
#	$ans_2.rotation = count * delta
	pass
	
func on_answer_pressed(is_good_answer : bool):
	var answer = AnswerListenerComponent.answer.false
	if is_good_answer == true:
		print ("true")
		answer = AnswerListenerComponent.answer.true
	for listener in answer_listeners:
		var component : AnswerListenerComponent = listener as AnswerListenerComponent
		if component != null:
			component.set_answer(answer)		

#	clean_up()


func clean_up():
	queue_free()


