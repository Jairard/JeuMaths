extends System

class_name AnswerInvaderSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Invader, ComponentsLibrary.AnswerListener, ComponentsLibrary.End_invader]

func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Endfight] #endfightinvader

func _process_node(dt : float, components : Dictionary) -> void:

	var answ 			= components[ComponentsLibrary.AnswerListener] 	as AnswerListenerComponent
	var invader 			= components[ComponentsLibrary.Invader] 	as InvaderComponent
	var end_comp			= components[ComponentsLibrary.End_invader]			as EndInvaderComponent

	var answer = answ.get_answer()
	if end_comp != null:
		if answer == AnswerListenerComponent.answer.true:
			end_comp.set_answer(true)
			if end_comp.get_answer():
				invader.set_gold(invader.get_gold() + 1)
				print("gold : ", invader.get_gold())
				end_comp.get_node().queue_free()

		if answer == AnswerListenerComponent.answer.false:
			end_comp.set_answer(true)
			if end_comp.get_answer():
				invader.set_health(invader.get_health() - 1)

		end_comp.set_answer(false)
		answ.set_answer(AnswerListenerComponent.answer.none)
