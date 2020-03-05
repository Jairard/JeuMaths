extends System

class_name AnswerSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.AnswerListener,ComponentsLibrary.Spell, ComponentsLibrary.AnswertoSpell,
			ComponentsLibrary.Collision, ComponentsLibrary.Damage, ComponentsLibrary.Health]

func _get_optional_components() -> Array:
	return [ComponentsLibrary.Scoreglobal,
		   ComponentsLibrary.Node_Enemy, ComponentsLibrary.Node_Hero]


func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Endfight]

func init_spell(node : Node2D, target : Node2D, damage : int) -> void:
	ECS.add_component(node, ComponentsLibrary.Position)
	var target_comp = ECS.add_component(node, ComponentsLibrary.Nodegetid) as NodegetidComponent
	target_comp.init(target)
	ECS.add_component(node, ComponentsLibrary.Collision)
	var spl_dmg_comp = ECS.add_component(node, ComponentsLibrary.Damage) as DamageComponent
	spl_dmg_comp.init(damage)


func _process_node(dt : float, components : Dictionary) -> void:

	var answ 			= components[ComponentsLibrary.AnswerListener] 	as AnswerListenerComponent
	var answtospell 	= components[ComponentsLibrary.AnswertoSpell]	as AnswertoSpellComponent
	var spl 			= components[ComponentsLibrary.Spell] 			as SpellComponent
	var col_comp		= components[ComponentsLibrary.Collision] 		as CollisionComponent
	var score_comp		= components[ComponentsLibrary.Scoreglobal] 	as ScoreglobalcounterComponent
	var health_comp		= components[ComponentsLibrary.Health]			as HealthComponent
	var node_hero		= components[ComponentsLibrary.Node_Hero]		as NodeHeroComponent
	var node_enemy		= components[ComponentsLibrary.Node_Enemy]		as NodeEnemyComponent

	var answer = answ.get_answer()																#true / false / none

	var spell_name = answtospell.get_spell_name(answer)
	var spell : Node2D = spl.get_spell(spell_name)  											# return node to instance
	var current_health = health_comp.get_health()

	if score_comp != null:
		if answer == AnswerListenerComponent.answer.true:															# COUNTER GOOD ANSWERS
			score_comp.set_good_answer(score_comp.get_good_answer() + 1)
			FileBankUtils.good_answer += 1
			print ("+2")
			print("true : ", FileBankUtils.good_answer)
		if answer == AnswerListenerComponent.answer.false:															# COUNTER WRONG ANSWERS
			score_comp.set_wrong_answer(score_comp.get_wrong_answer() + 1)
			print ("+1")
			print("wrong : ", FileBankUtils.wrong_answer)
			FileBankUtils.wrong_answer += 1

	if spell != null and health_comp != null:

		if node_hero != null or node_enemy != null:
			var target : Node2D = answtospell.get_spell_target(answer)
			var damage : int = answtospell.get_spell_damage(answer)
			var target_health_component 	: HealthComponent 	= _getComponentOfEntity(target.get_instance_id(), ComponentsLibrary.Health)
			var target_health : int = target_health_component.get_health()

			if target_health - damage >= 0:
#				print ("target : ", target_health - damage)
				answtospell.get_node().add_child(spell)
				init_spell(spell,target,damage)
				answ.reset()
			else :
				answtospell.get_node().add_child(spell)
				init_spell(spell,target,damage)
				answ.delete()




	answ.set_answer(AnswerListenerComponent.answer.none)



