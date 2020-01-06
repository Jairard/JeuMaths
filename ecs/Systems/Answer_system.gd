extends System

class_name AnswerSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.AnswerListener,ComponentsLibrary.Spell, ComponentsLibrary.AnswertoSpell, 
			ComponentsLibrary.Collision]

func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Endfight]

func init_spell(node : Node2D, target : Node2D) -> void:
	ECS.add_component(node, ComponentsLibrary.Position)
	var target_comp = ECS.add_component(node, ComponentsLibrary.Nodegetid) as NodegetidComponent
	target_comp.init(target)	 
	ECS.add_component(node, ComponentsLibrary.Collision)
	
func _process_node(dt : float, components : Dictionary) -> void:
	
	var answ 			= components[ComponentsLibrary.AnswerListener] 	as AnswerListenerComponent
	var answtospell 	= components[ComponentsLibrary.AnswertoSpell]	as AnswertoSpellComponent
	var spl 			= components[ComponentsLibrary.Spell] 			as SpellComponent
	var col_comp		= components[ComponentsLibrary.Collision] 		as CollisionComponent
	
	var answer = answ.get_answer()																#true / false / none
	
	var spell_name = answtospell.get_spell_name(answer)
	var spell : Node2D = spl.get_spell(spell_name)  											# return node to instance
	if spell != null:
		answtospell.get_node().add_child(spell)	
		var target : Node2D = answtospell.get_spell_target(answer)
		init_spell(spell,target)
		answ.reset()
		
	answ.set_answer(AnswerListenerComponent.answer.none)