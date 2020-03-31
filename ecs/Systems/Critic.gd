extends System

class_name CriticSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Damage, ComponentsLibrary.Node_Hero, ComponentsLibrary.AnswertoSpell]
	

func _process_node(dt : float, components : Dictionary) -> void:

	var comp_damage		 	= 	components[ComponentsLibrary.Damage] 			as 	DamageComponent
	var comp_answer			=   components[ComponentsLibrary.AnswertoSpell]		as AnswertoSpellComponent

#	comp_damage.critic = 0
	comp_damage.critic += dt

	if comp_damage.critic < comp_damage.timer and comp_damage._bool:
		comp_damage.set_damage(int(comp_damage.get_damage() * 1.2))
		comp_damage._bool = false
	elif comp_damage.critic >= comp_damage.timer and comp_damage._bool == false:
		comp_damage.set_damage(comp_damage.get_damage() / 1.2)
		comp_damage._bool = true

