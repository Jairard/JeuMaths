extends Node2D

var count = 0
var angle : float = 0
var answer_listeners  : Array = []
var pictures : Dictionary = {}

var load_calcul = load_c("res://Assets/Questions/Questions.json")

var timer : Timer = null
var timer_label : Label = null
var button_answer : Button = null
var control_answer : Control = null
var control_question : Control = null
var question : Label = null
var colorRect : ColorRect = null
var control_1 : Control = null
var control_2 : Control = null
var center_answer : CenterContainer = null

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
	return dict

func setup_question(dict : Array) -> void:
	control_1 = Control.new()
	control_2 = Control.new()
	center_answer = CenterContainer.new()
	control_1.self_modulate = Color(1, 1, 1, 0)
	control_2.self_modulate = Color(1, 1, 1, 0)
	var font_question = "res://font/Colored Crayons.ttf"
	var font_answer = "res://font/Colored Crayons.ttf"
	question = NodeUtils.create_label(Vector2(0,0), Vector2(0,0), 
						   Color.yellowgreen, font_question, 35,2, Color.black)
	control_question = Control.new() 
	control_question.rect_size = Vector2(200,50)
	control_question.self_modulate = Color(1, 1, 1, 0)
	$CanvasLayer.add_child(control_question)
	control_question.add_child(question)


	var random_theme 	: int 			= RandomUtils.randi_to(len(dict))
	var questions		: Array 		= dict[random_theme]["questions"]
	var random_question : int 			= RandomUtils.randi_to(len(questions))
	var chosen_question : Dictionary 	= questions[random_question]

	print ("theme : ", random_theme)
	if random_theme < 8:
		var texture_frac_1 = Sprite.new()
		var frac_1 = chosen_question["question"][0]
		texture_frac_1.texture = pictures[frac_1]
		control_question.add_child(texture_frac_1)
		texture_frac_1.set_position(question.get_position() + Vector2(-35,20))
		question.text 	= chosen_question["question"][1]
		var texture_frac_2 = Sprite.new()
		var frac_2 = chosen_question["question"][2]
		texture_frac_2.texture = pictures[frac_2]
		control_question.add_child(texture_frac_2)
		texture_frac_2.set_position(question.get_position() + Vector2(50,20))
	elif random_theme == 8:
		question.text 	= chosen_question["question"][0]
		var texture_frac = Sprite.new()
		var frac = chosen_question["question"][1]
		texture_frac.texture = pictures[frac]
		control_question.add_child(texture_frac)
		texture_frac.set_position(question.get_position() + Vector2(50,20))
	else:
		question.text 	= chosen_question["question"]

	var answers 	: Array = chosen_question["answers"]

	var ans_position : Vector2 = Vector2(question.get_position().x - 150 , question.get_position().y + 50)
	for ans in answers:
		control_answer = Control.new()
		control_answer.self_modulate = Color(1, 1, 1, 0)
		button_answer = Button.new()
		button_answer.self_modulate = Color(1, 1, 1, 0)

		var label_answer = NodeUtils.create_label(Vector2(0,0), Vector2(0,0), 
						   Color.orangered, font_question, 30,1, Color.black)
		label_answer.text = ans["text"]

		if random_theme < 9:
			var texture_fraction = Sprite.new()
			texture_fraction.centered = false
			texture_fraction.texture = pictures[ans["text"]]
			button_answer.add_child(texture_fraction)

		else:
			button_answer.add_child(label_answer)

		ans_position.x += 160
		button_answer.set_position(ans_position)
		button_answer.rect_size = Vector2(50,60)
		question.add_child(control_1)
		control_1.add_child(control_2)
		control_2.add_child(control_answer)
		control_answer.add_child(button_answer)
			
		control_1.set_pivot_offset(Vector2(0,50))
		control_1.set_position(Vector2(question.rect_size / 2) + Vector2(-50,30))


		var font_timer = "res://Assets/Font/Comfortaa-Bold.ttf"
		timer = NodeUtils.create_timer(4, true, true)
		add_child(timer)

#		if ans["is_good_answer"] == true:
#			var style : StyleBoxFlat = StyleBoxFlat.new()
#			style.set_bg_color(Color(0,255,0))
#			button_answer.add_stylebox_override("hover",style)
		button_answer.connect("pressed", self, "on_answer_pressed", [ans["is_good_answer"]])


func _ready():
	var path = "res://Tools/Fractions/"
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			break
		elif file_name.ends_with(".png"):
			pictures[file_name] = load(path + "/" + file_name)
	dir.list_dir_end()
	setup_question(load_calcul)


func _process(delta):
	
	angle += delta
	control_1.set_rotation(angle)
	control_2.set_rotation(-angle)


	if int(timer.get_time_left()) > 0:
		question.add_color_override("font_color", Color.greenyellow)
	else:
		question.add_color_override("font_color", Color.green)
	pass

func on_answer_pressed(is_good_answer : bool):
	var answer = AnswerListenerComponent.answer.false
	if is_good_answer == true:
		answer = AnswerListenerComponent.answer.true
	for listener in answer_listeners:
		var component : AnswerListenerComponent = listener as AnswerListenerComponent
		if component != null:
			component.set_answer(answer)


