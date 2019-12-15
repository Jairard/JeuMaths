extends Component

class_name AnswerListenerComponent

enum answer {true, false, none}
var answr = answer.none
var scene 		: Node2D = null
var resource 	: Resource = null

func get_answer() : 
	return answr
	
func set_answer(answer) -> void :
	answr = answer

func init(_scene : Node2D, _resource : Resource) -> void:
	scene 		= _scene
	resource 	= _resource
	
func set_scene(_scene : Node2D) -> void:
	  scene = _scene

func reset() -> void:
	var scene_parent : Node2D = scene.get_parent()
	var new_instance : Node2D = resource.instance()
	scene_parent.add_child(new_instance)
	var listeners : Array = scene.get_answer_listener()
	
	new_instance.set_answer_listener(listeners)
	scene.queue_free()
	
	for lis in listeners:
		var comp : Component = lis as AnswerListenerComponent
		if comp != null:
			comp.set_scene(new_instance)