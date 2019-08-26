extends System

class_name AnimationSystem

func _get_used_components() -> Array:
	return [ComponentsLibrary.Movement, ComponentsLibrary.Position]

func _process_node(dt : float, components : Dictionary) -> void:
	
	var comp = components[ComponentsLibrary.Movement] as MovementComponent
	var hero_Node  = comp.get_node()
	var child_anim = hero_Node.get_node("anim_hero")
	
	if comp.get_direction() == comp.dir.right :
		child_anim.play("anim_right")
		
	if comp.get_direction() == comp.dir.left :
		child_anim.play("anim_left")

	if comp.get_direction() == comp.dir.none :
		child_anim.play("anim_jump")

	if comp.is_jumping() == true :
		child_anim.play("anim_jump")