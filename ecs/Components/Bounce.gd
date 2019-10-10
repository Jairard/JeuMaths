extends Component

class_name BounceComponent

var bounce : bool = false

func is_bouncing() -> bool :
	return bounce			#stocker normal dans un get_normal
	
func set_is_bouncing(value : bool) -> void :			#rajouter parametre normal
	bounce = value