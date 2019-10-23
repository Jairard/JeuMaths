extends Component

class_name VelocityComponent

var vel : Vector2 = Vector2(0,0)
var debug_line_id : int = -1

func get_velocity() -> Vector2:
	return vel
	
func set_velocity(_vel : Vector2) -> void:
	var x = abs(_vel.x)
	var y = abs(_vel.y)
	if (10 < x and x < 90) or (y > 10 and y < 90) : 
		print ("set_velocity : " + str(vel) + " -> " + str(_vel))
	vel = _vel
	DebugUtils.remove_shape(debug_line_id)
	debug_line_id = draw_debug_line_to(vel, Color.cyan, -1)

func _on_destroyed() -> void:
	DebugUtils.remove_shape(debug_line_id)
