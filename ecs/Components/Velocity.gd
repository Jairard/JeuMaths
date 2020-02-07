extends Component

class_name VelocityComponent

var vel : Vector2 = Vector2(0,0)
var debug_line_id : int = -1

func get_velocity() -> Vector2:
	return vel

func set_velocity(_vel : Vector2) -> void:
	vel = _vel
	DebugUtils.remove_shape(debug_line_id)
	debug_line_id = draw_debug_line_to(vel, Color.cyan, -1)

func _on_destroyed() -> void:
	DebugUtils.remove_shape(debug_line_id)
