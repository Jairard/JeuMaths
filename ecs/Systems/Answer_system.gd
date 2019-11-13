extends System

class_name AnswerSystem

func _get_used_components() -> Array:
	return [ComponentsLibrary.AnswerListener,ComponentsLibrary.Spell, ComponentsLibrary.AnswertoSpell]

func getspellname(answer) -> String:
	if answer == AnswerListenerComponent.answer.true :
		return "spell_hero"
#		print ("spell_hero")
	if answer == AnswerListenerComponent.answer.false :
		return "spell_enemy"
#		print ("spell_enemy")
	else :
		return ""

func _process_node(dt : float, components : Dictionary) -> void:
	
	var answ 		= components[ComponentsLibrary.AnswerListener] as AnswerListenerComponent
	var answtospell = components[ComponentsLibrary.AnswertoSpell] as AnswertoSpellComponent
	var spl 		= components[ComponentsLibrary.Spell] as SpellComponent
	
	var answer = answ.get_answer()																#true / false / none
	var spell_name = answtospell.get_spell_name(answer)											#return spell name
	var spell : Node2D = spl.get_spell(spell_name)  											# return node to instance
	if spell != null:
		answtospell.get_node().add_child(spell)							
	
	