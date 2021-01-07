extends System

class_name AnswerInvaderSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.AnswerListener, ComponentsLibrary.Invader_calcul]

func _get_system_dependencies() -> Array:
	return [SystemsLibrary.End_invader] 

func _process_node(dt : float, components : Dictionary) -> void:

	var answ 				= components[ComponentsLibrary.AnswerListener] 	as AnswerListenerComponent
	var calcul 				= components[ComponentsLibrary.Invader_calcul] 	as InvaderCalculComponent

	var invader 			= calcul.get_invader()

	var answer = answ.get_answer()
	if answer == AnswerListenerComponent.answer.true:
			invader.set_gold(invader.get_gold() + 1)
			AnimationUtils.validate_answer(calcul.get_node().get_parent())
			answ.get_node().queue_free()

	if answer == AnswerListenerComponent.answer.false:
			invader.set_health(invader.get_health() - 1)
			var node = invader.get_node()
			AnimationUtils.ShakeScreen(node, 50)
			answ.get_node().queue_free()

	answ.set_answer(AnswerListenerComponent.answer.none)

	if invader.lose_health:
		invader.set_health(invader.get_health() - 1)
		invader.lose_health = false
