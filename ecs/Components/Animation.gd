extends Component

class_name AnimationComponent

enum anim {left, right, jump, idle}

var animation_names : Dictionary = {}
var animation_player : AnimationPlayer = null

func init(_anim_name : Dictionary, _animation_player : AnimationPlayer) -> void :
	animation_names = _anim_name
	animation_player = _animation_player
	
func play(key) -> void : 
	if animation_player != null and animation_names.has(key) :
		var anim_to_play = animation_names[key]
		animation_player.play(anim_to_play)
		
