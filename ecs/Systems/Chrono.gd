extends System

class_name ChronoSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Chrono]

func _process_node(dt : float, components : Dictionary) -> void:
	var chrono 			= components[ComponentsLibrary.Chrono] 			as ChronoComponent

	if chrono != null and chrono.get_new_answer() and chrono.get_new_question():
		chrono.set_new_answer(false)
		chrono.set_new_question(false)
		if chrono.get_associated_answer() == chrono.get_answer():
			chrono.set_gold(chrono.get_gold() + 1)
			chrono.set_delete_nodes(true)
			chrono.set_answer_count(chrono.get_answer_count() + 1)
		else:
			var timerNode = chrono.get_node().get_node("Timer")
			var timer = timerNode.get_time_left()
			var new_timer = timer - 5
			timerNode.start(new_timer)
			chrono.set_discolor_nodes(true)
			var node = chrono.get_node()
			AnimationUtils.ShakeScreen(node, 50)
