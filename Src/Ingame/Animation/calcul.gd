extends Node2D

var count = 0
var answer_listeners  : Array = []
var load_calcul = load_c("res://Assets/Questions/questions.json")

func set_answer_listener(listeners : Array) -> void:
	answer_listeners  = listeners
	
func load_c(path : String) -> Dictionary:
	var file = File.new()
	file.open(path, File.READ)
	var text = file.get_as_text()
	var dict = parse_json(text)
	file.close()
	return dict
	
func setup_question(dict : Array) -> void:
	randomize()
	var rq = randi() % 2
	var ra = randi() % 10
	$question/MarginContainer/calcul.text = dict[rq]["questions"][ra]["question"]
	var answers : Array = dict[rq]["questions"][ra]["answers"]
	var ans_position : Vector2 = Vector2(0,100) 
	for ans in answers:
		var button : Button = Button.new() 
		button.text = ans["text"]
		ans_position.x += 100
		button.set_position(ans_position)
		add_child(button)
		button.connect("pressed", self, "on_answer_pressed", [ans["is_good_answer"]])
		

func _ready():
	
	setup_question(load_calcul)

func _process(delta):
	count += 1

#	$ans_1.rotation = count * delta
#	$ans_2.rotation = count * delta
	pass
	
func on_answer_pressed(is_good_answer : bool):
	var answer = AnswerListenerComponent.answer.false
	if is_good_answer == true:
		answer = AnswerListenerComponent.answer.true
	for listener in answer_listeners:
		var component : AnswerListenerComponent = listener as AnswerListenerComponent
		if component != null:
			component.set_answer(answer)		
	setup_question(load_calcul)


