extends Component

class_name AnimationComponent

enum animation {left, right, jump, none}

enum anim_name {anim_left, anim_right, anim_jump}

var init_anim = anim_name.anim_jump

func init_animation_Node(anim_name) -> void :
	init_anim = anim_name
	pass
	
func get_anim() -> bool :
	return init_anim