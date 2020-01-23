extends System

class_name AnswerSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.AnswerListener,ComponentsLibrary.Spell, ComponentsLibrary.AnswertoSpell, 
			ComponentsLibrary.Collision, ComponentsLibrary.Damage]

func _get_optional_components() -> Array:
	return [ComponentsLibrary.Scoregolbal]
	
	
func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Endfight]

func init_spell(node : Node2D, target : Node2D, damage : int) -> void:
	ECS.add_component(node, ComponentsLibrary.Position)
	var target_comp = ECS.add_component(node, ComponentsLibrary.Nodegetid) as NodegetidComponent
	target_comp.init(target)	 
	ECS.add_component(node, ComponentsLibrary.Collision)
	var spl_dmg_comp = ECS.add_component(node, ComponentsLibrary.Damage) as DamageComponent
	spl_dmg_comp.init(damage)
	print ("spl dmg : ",spl_dmg_comp.get_damage())
	
	
func _process_node(dt : float, components : Dictionary) -> void:
	
	var answ 			= components[ComponentsLibrary.AnswerListener] 	as AnswerListenerComponent
	var answtospell 	= components[ComponentsLibrary.AnswertoSpell]	as AnswertoSpellComponent
	var spl 			= components[ComponentsLibrary.Spell] 			as SpellComponent
	var col_comp		= components[ComponentsLibrary.Collision] 		as CollisionComponent
	var score_comp		= components[ComponentsLibrary.Scoregolbal] 	as ScoreglobalcounterComponent
		
	var answer = answ.get_answer()																#true / false / none
	
	var spell_name = answtospell.get_spell_name(answer)
	var spell : Node2D = spl.get_spell(spell_name)  											# return node to instance
	
	if score_comp != null:
		if answer == AnswerListenerComponent.answer.true:															# COUNTER GOOD ANSWERS
			score_comp.set_good_answer(score_comp.get_good_answer() + 1)
		if answer == AnswerListenerComponent.answer.false:															# COUNTER WRONG ANSWERS
			score_comp.set_wrong_answer(score_comp.get_wrong_answer() + 1)
	
	if spell != null:

		answtospell.get_node().add_child(spell)	
		var target : Node2D = answtospell.get_spell_target(answer)
		var damage : int = answtospell.get_spell_damage(answer)
		init_spell(spell,target,damage)
		answ.reset()
		
	answ.set_answer(AnswerListenerComponent.answer.none)
	
	
	