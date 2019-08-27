extends System

class_name AnimationSystem

# Do you really need Position component ?
# TODO: inspect this case
func _get_used_components() -> Array:
	return [ComponentsLibrary.Movement, ComponentsLibrary.Position]

func _process_node(dt : float, components : Dictionary) -> void:
	
	var comp = components[ComponentsLibrary.Movement] as MovementComponent
	# This method shouldn't care about which node it is
	# TODO: rename hero_Node
	var hero_Node  = comp.get_node()
	# This is pretty specific to the hero node.
	# TODO:
	# - create an AnimationComponent class
	# - store the animation node in it (via an init method)
	# - use it here to get the concerned node
	var child_anim = hero_Node.get_node("anim_hero")
	
	# The animation names are data that could also be stored in a Component
	# TODO:
	# - add an animation enum to AnimationComponent (something like {left, right, jump})
	# - add a dictionary in the AnimationComponent class that will contain the animation names
	# - initialize this dictionary in the init() method
	# - replace the following code by a conversion from comp.dir to AnimationComponent.anim
	# - call AnimationComponent.animate method with the corresponding animation type
	if comp.get_direction() == comp.dir.right :
		child_anim.play("anim_right")
		
	if comp.get_direction() == comp.dir.left :
		child_anim.play("anim_left")

	if comp.get_direction() == comp.dir.none :
		# Are you sure about this ?
		child_anim.play("anim_jump")

	if comp.is_jumping() == true :
		child_anim.play("anim_jump")