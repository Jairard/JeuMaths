extends Component

class_name PositionComponent

var target_pos 	:  Vector2
var shooter_pos :  Vector2
var angle_deg = 0

func get_position() -> Vector2:
	return get_node().get_position()

func set_position(pos : Vector2) -> void :
	get_node().set_position(pos)

func move_and_slide(velocity : Vector2) -> void:
	get_node().move_and_slide(velocity, Vector2(0, -1))

func transform(target_pos : Vector2, shooter_pos : Vector2)  :
	var direction = target_pos - shooter_pos						# separate 2 func
	var angle_rad = direction.angle()								# one for direction
	angle_deg = rad2deg(angle_rad)									# one for angle
