extends Component

class_name MovementComponent
enum dir {left, right, none}

var velocity 	:  Vector2
var shooter_pos :  Vector2
var target_pos  :  Vector2
var fire_spawn  :  Vector2
var fire_stop   :  Vector2
var line        :  Vector2

var node_navigation : Node2D

var direction = dir.none
var jump 	: bool 	= false
var impulse : int 	= 0
var lateral_velocity : int = 0

func get_direction() :		# -> dir
	return direction	
	
func set_direction(dir) -> void :	
	direction = dir
	
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
		

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	