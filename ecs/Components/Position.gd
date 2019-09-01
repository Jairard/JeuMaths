extends Component

class_name PositionComponent

func get_position() -> Vector2:
	return get_node().get_position()

func set_position(pos : Vector2) -> void :
	get_node().set_position(pos)

func move_and_slide(velocity : Vector2) -> void:
	get_node().move_and_slide(velocity, Vector2(0, -1))

