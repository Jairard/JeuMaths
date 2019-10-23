extends System

class_name AnswerSystem

func _get_used_components() -> Array:
	return [ComponentsLibrary.AnswerListener,ComponentsLibrary.Spell]

func getspellname(answer) -> String:
	if answer == AnswerListenerComponent.answer.true :
		return "spell"
	else :
		return ""

func _process_node(dt : float, components : Dictionary) -> void:
	
	var answ = components[ComponentsLibrary.AnswerListener] as AnswerListenerComponent
	var spl = components[ComponentsLibrary.Spell] as SpellComponent
	var spellname = getspellname(answ.get_answer())							# component answertospell
	
	
#	if  answ.get_answer() == answ.answer.true : 
#		spl.get_spell() == spl.spells.spell
	var spell : Node2D = spl.get_spell(spellname)       
	if spell != null:
		spl.get_node().add_child(spell)

#	if answ.get_answer() == answ.answer.false :
#		spl.get_spell() == spl.spells.arrow
#
#	else :
#		spl.get_spell() == spl.spells.none 