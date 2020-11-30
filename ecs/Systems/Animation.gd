extends System

class_name AnimationSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Movement, ComponentsLibrary.Animation]

func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Move, SystemsLibrary.Patrol, SystemsLibrary.Input]

func _process_node(dt : float, components : Dictionary) -> void:
	var comp		 = 	components[ComponentsLibrary.Movement] as MovementComponent
	var comp_anim	 = 	components[ComponentsLibrary.Animation] as AnimationComponent
	if comp.get_direction() == MoveUtils.dir.right :
		comp_anim.play(comp_anim.anim.right)
		comp_anim.get_node().get_node("Sprite").flip_h = false
	if comp.get_direction() == MoveUtils.dir.left :
		comp_anim.play(comp_anim.anim.right)
		comp_anim.get_node().get_node("Sprite").flip_h = true

	if comp.get_direction() == MoveUtils.dir.none :
		comp_anim.play(comp_anim.anim.idle)

	if comp.is_jumping() == true :
		comp_anim.play(comp_anim.anim.jump)

	if comp.get_direction() == MoveUtils.dir.colliding :
		comp_anim.play(comp_anim.anim.colliding)
