extends Component

class_name AnswerListenerComponent

enum answer {true, false, none}
var answr = answer.none
var scene 		: Node2D = null
var resource 	: Resource = null
var questions 
var constants

func get_answer() :
	return answr

func set_answer(answer) -> void :
	answr = answer

func init(_scene : Node2D, _resource : Resource, _questions, _constants) -> void:
	scene 		= _scene
	resource 	= _resource
	questions = _questions
	constants = _constants

func set_scene(_scene : Node2D) -> void:
	  scene = _scene

func reset() -> void:
	var scene_parent : Node2D = scene.get_parent()
	var new_instance : Node2D = resource.instance()
	new_instance.setup_question(questions, constants)
	scene_parent.add_child(new_instance)
	var listeners : Array = scene.get_answer_listener()

	new_instance.set_answer_listener(listeners)
	scene.queue_free()

	for lis in listeners:
		var comp : Component = lis as AnswerListenerComponent
		if comp != null:
			comp.set_scene(new_instance)

func reset_invader() -> void:
	var scene_parent : Node2D = scene.get_parent()
	var new_instance : Node2D = resource.instance()
	new_instance.setup_question(questions)
	scene_parent.add_child(new_instance)
	var listeners : Array = scene.get_answer_listener()

	new_instance.set_answer_listener(listeners)
	scene.queue_free()

	for lis in listeners:
		var comp : Component = lis as AnswerListenerComponent
		if comp != null:
			comp.set_scene(new_instance)

func delete() -> void:
	scene.queue_free()
