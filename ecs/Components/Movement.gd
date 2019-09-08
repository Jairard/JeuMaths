extends Component

class_name MovementComponent
enum dir {left, right, none}

var velocity 	:  Vector2
var shooter_pos :  Vector2
var target_pos  :  Vector2

var node_navigation : Node2D

var direction = dir.none
var jump = false

func get_direction() :		# -> dir
	return direction	
	
func set_direction(dir) -> void :	# dir : dir
	direction = dir

func is_jumping() -> bool :
	return jump
	
func set_is_jumping(value : bool) -> void :
	jump = value

func _path(target_pos : Vector2, shooter_pos : Vector2, node_navigation : Node2D):
	var path : PoolVector2Array = node_navigation.get_simple_path(shooter_pos, target_pos, false)
	
	if path.size() != 0 :
		velocity = path[1] - shooter_pos