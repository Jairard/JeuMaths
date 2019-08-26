extends Component

class_name MovementComponent
enum dir {left, right, none}

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