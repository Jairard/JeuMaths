extends Node2D

var count = 0
var answer_listeners  : Array = []
#var load_calcul_6 = load_c("res://Assets/Questions/questions_6.json")
#var load_calcul_5 = load_c("res://Assets/Questions/questions_5.json")
#var load_calcul_4 = load_c("res://Assets/Questions/questions_4.json")
#var load_calcul_3 = load_c("res://Assets/Questions/questions_3.json")
var load_calcul = load_c("res://Assets/Questions/questions.json")

var timer : Timer = null
var timer_label : Label = null
var button_answer : Button = null
var question : Label = null
var colorRect : ColorRect = null


func set_answer_listener(listeners : Array) -> void:
	answer_listeners  = listeners

func get_answer_listener() -> Array:
	return answer_listeners

func load_c(path : String) -> Dictionary:
	var file = File.new()
	file.open(path, File.READ)
	var text = file.get_as_text()
	var dict = parse_json(text)
	file.close()
#	print (dict)
	return dict

func setup_question(dict : Array) -> void:
	var font_question = "res://Assets/Font/Comfortaa-Bold.ttf"
	var dynamic_font_question = DynamicFont.new()
	dynamic_font_question.font_data = load(font_question)
	dynamic_font_question.size = 50
	dynamic_font_question.outline_size = 5
	dynamic_font_question.outline_color = Color( 0, 0, 0, 1 )
	dynamic_font_question.use_filter = true
	question = Label.new()
	add_child(question)
	question.add_font_override("font", dynamic_font_question)

	var random_theme 	: int 			= RandomUtils.randi_to(len(dict))
	var questions		: Array 		= dict[random_theme]["questions"]
	var random_question : int 			= RandomUtils.randi_to(len(questions))
	var chosen_question : Dictionary 	= questions[random_question]

	question.text = chosen_question["question"]
	var answers 		: Array = chosen_question["answers"]

	var ans_position : Vector2 = Vector2(0,100)
	for ans in answers:
		button_answer = Button.new()
		button_answer.text = ans["text"]
		ans_position.x += 100
		button_answer.set_position(ans_position)
		add_child(button_answer)
		
		var font_timer = "res://Assets/Font/Comfortaa-Bold.ttf"
		var dynamic_font_timer = DynamicFont.new()
		dynamic_font_timer.font_data = load(font_timer)
		dynamic_font_timer.size = 50
		dynamic_font_timer.outline_size = 5
		dynamic_font_timer.outline_color = Color( 0, 0, 0, 1 )
		dynamic_font_timer.use_filter = true

		timer = Timer.new()
		question.add_child(timer)
		timer_label = Label.new()
		question.add_child(timer_label)
		timer_label.show()				
		timer_label.set_position(Vector2(question.get_position().x + 100, question.get_position().y - 50))				
		timer_label.rect_size.x = 200
		timer_label.rect_size.y = 200
		timer_label.align = VALIGN_CENTER
		timer_label.add_font_override("font", dynamic_font_timer)
		timer_label.add_color_override("font_color", Color.red)
		timer.set_wait_time(4)	
		timer.set_one_shot(true)
		timer.set_autostart(true)	
		timer.start()				


		if ans["is_good_answer"] == true:
			var style : StyleBoxFlat = StyleBoxFlat.new()
			style.set_bg_color(Color(0,255,0))
			button_answer.add_stylebox_override("hover",style)
		button_answer.connect("pressed", self, "on_answer_pressed", [ans["is_good_answer"]])


func _ready():
#	answer_listeners = []
#	if FileBankUtils.classroom == 6:
#		setup_question(load_calcul_6)
#	if FileBankUtils.classroom == 5:
#		setup_question(load_calcul_5)
#	if FileBankUtils.classroom == 4:
#		setup_question(load_calcul_4)
#	if FileBankUtils.classroom == 3:
#		setup_question(load_calcul_3)
	setup_question(load_calcul)
	

func _process(delta):
#	count += 1
#	button_answer.set_rotation(count*delta)
#	$ans_1.rotation = count * delta
#	$ans_2.rotation = count * delta
	timer_label.set_text(str(int(timer.get_time_left())))
	if int(timer.get_time_left()) > 0:
#		question.set("custom_colors/font_color", Color(79,187,67,255))
		question.add_color_override("font_color", Color.blue)
	else:
#		question.set("custom_colors/font_color", Color(255,255,255,255))
		question.add_color_override("font_color", Color.black)		
		


func on_answer_pressed(is_good_answer : bool):
	var answer = AnswerListenerComponent.answer.false
	if is_good_answer == true:
		answer = AnswerListenerComponent.answer.true
	for listener in answer_listeners:
		var component : AnswerListenerComponent = listener as AnswerListenerComponent
		if component != null:
			component.set_answer(answer)


