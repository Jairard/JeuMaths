extends Component

class_name VelocityComponent

var vel : Vector2 = Vector2(0,0)

func get_velocity() -> Vector2:
	return vel
	
func set_velocity(_vel : Vector2) -> void:
	var x = abs(_vel.x)
	var y = abs(_vel.y)
	if (10 < x and x < 90) or (y > 10 and y < 90) : 
		print ("set_velocity : " + str(vel) + " -> " + str(_vel))
	vel = _vel
	
