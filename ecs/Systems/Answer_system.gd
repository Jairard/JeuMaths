extends System

class_name AnswerSystem

func _get_used_components() -> Array:
	return [ComponentsLibrary.Answer,ComponentsLibrary.Spell]

func _process_node(dt : float, components : Dictionary) -> void:
	
	var answ = components[ComponentsLibrary.Answer] as AnswerComponent
	var spl = components[ComponentsLibrary.Spells] as SpellComponent
	
	if  answ.get_answer() == answ.answer.true : 
		spl.get_spell() == spl.spells.spell_1 

	if answ.get_answer() == answ.answer.false :
		spl.get_spell() == spl.spells.spell_2 

	else :
		spl.get_spell() == spl.spells.none 