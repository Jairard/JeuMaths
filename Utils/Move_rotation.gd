extends Node

var direction : Vector2

func get_direction() :		# -> dir
	return direction	
	
func set_direction(target : Vector2, shooter : Vector2) -> void :	# dir : dir
	direction = target - shooter
	print ("direction :" + str(direction))
	
func dir_to_angle(dir : Vector2) -> int :
	var angle_rad = direction.angle()								
	var angle_deg = rad2deg(angle_rad)
	return angle_deg