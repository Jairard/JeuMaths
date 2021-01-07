extends Component

class_name MovementComponent

var direction = MoveUtils.dir.none
var jump 	: bool 	= false
var impulse : int 	= 0
var start_jumping = false
var lateral_velocity : int = 0
var target : Vector2 = Vector2(0,0)

func get_target() :
	return target

func set_target(dir) -> void :
	target = dir
	
func get_direction() :		# -> dir
	return direction

func set_direction(dir) -> void :
	direction = dir

func set_start_jumping(value) -> void :
	start_jumping = value
	
func get_start_jumping() -> bool :
	return start_jumping

func get_lateral_velocity() -> int:
	return lateral_velocity

func set_lateral_velocity(_lateral_velocity : int) -> void :
	lateral_velocity = _lateral_velocity

func get_jump_impulse() -> int:
	return impulse

func set_jump_impulse(_impulse : int) -> void :
	impulse = _impulse

func is_jumping() -> bool :
	return jump

func set_is_jumping(value : bool) -> void :
	jump = value
















