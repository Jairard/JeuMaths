extends Component

class_name PathComponent

var velocity : Vector2

func init(target_position : Vector2, shooter_position : Vector2, node_navigation : Node2D) :
	
	var path : PoolVector2Array = node_navigation.get_simple_path(shooter_position, target_position, false)
	
	if path.size() != 0 :
		velocity = path[1] - shooter_position 