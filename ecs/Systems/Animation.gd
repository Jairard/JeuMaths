extends System

class_name AnimationSystem

func _get_used_components() -> Array:
	return [ComponentsLibrary.Movement, ComponentsLibrary.Animation]

func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Move, SystemsLibrary.Patrol]

func _process_node(dt : float, components : Dictionary) -> void:
	
	var comp		 = 	components[ComponentsLibrary.Movement] as MovementComponent
	var comp_anim	 = 	components[ComponentsLibrary.Animation] as AnimationComponent
	
#	print (comp_anim.animation_names)
	
	if comp.get_direction() == comp.dir.right :
		comp_anim.play(comp_anim.anim.right)

	if comp.get_direction() == comp.dir.left :
		comp_anim.play(comp_anim.anim.left)

	if comp.get_direction() == comp.dir.none :
		comp_anim.play(comp_anim.anim.idle)

	if comp.is_jumping() == true :
		comp_anim.play(comp_anim.anim.jump)	