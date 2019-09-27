extends Node

var direction 	: Vector2
var vector 		: Vector2
var velocity 	: Vector2

func get_direction() :		# -> dir
	return direction	
	
func set_direction(target : Vector2, shooter : Vector2) -> void :	# dir : dir
	direction = target - shooter
	
func dir_to_angle(dir : Vector2) -> int :
	var angle_rad = direction.angle()								
	var angle_deg = rad2deg(angle_rad)
	return angle_deg
	
func get_direction_to(target_pos : Vector2, shooter_pos : Vector2, node_navigation : Node2D) -> Vector2 :
	var path : PoolVector2Array = node_navigation.get_simple_path(shooter_pos, target_pos, false)
	if path.size() > 1 :
		return (path[1] - shooter_pos).normalized()
	else : 
		return (target_pos - shooter_pos).normalized()
		

func vector_orthogonal(_vector : Vector2) -> Vector2:
	if ((_vector.x >= 0 and _vector.y <= 0) or (_vector.x >= 0 and _vector.y >= 0)
		or (_vector.x <= 0 and _vector.y >= 0) or (_vector.x <= 0 and _vector.y <= 0)):
		var r = randi() %2
		if r == 1 :
			vector.x =   _vector.x
			vector.y = - _vector.y
		else : 
			vector.x = - _vector.x
			vector.y =   _vector.y
			
	return vector
	
	
	
	
	
	
		
