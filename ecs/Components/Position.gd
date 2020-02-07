extends Component

class_name PositionComponent

var debug_rect_id : int = -1

func get_position() -> Vector2:
	return get_node().get_position()

func set_position(pos : Vector2) -> void :
	get_node().set_position(pos)
#	DebugUtils.remove_shape(debug_rect_id)
#	debug_rect_id = draw_debug_rect(Rect2(Vector2(-25,-25),Vector2(50,50)), Color.aqua, -1, true)

func move_and_slide(velocity : Vector2) -> Vector2:
	var slide : Vector2 = get_node().move_and_slide(velocity, Vector2(0, -1))
	DebugUtils.remove_shape(debug_rect_id)
	debug_rect_id = draw_debug_rect(Rect2(Vector2(-25,-25),Vector2(50,50)), Color.aqua, -1, true)
	return slide

func _on_destroyed() -> void:
	DebugUtils.remove_shape(debug_rect_id)

