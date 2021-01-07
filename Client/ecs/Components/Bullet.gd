extends Component

class_name BulletComponent

var position 	: Vector2 = Vector2(0,0)

func get_position() -> Vector2:
	return position

func set_position(value : Vector2) -> void:
	position = value
	position.x -= 1000

