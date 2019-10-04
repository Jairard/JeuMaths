extends Node

func dir_to_angle(dir : Vector2) -> int :
	var angle_rad = dir.angle()								
	var angle_deg = rad2deg(angle_rad)
	return angle_deg

func get_direction(target_pos : Vector2, shooter_pos : Vector2) -> Vector2:
	return (target_pos - shooter_pos).normalized()
	

func get_direction_to(target_pos : Vector2, shooter_pos : Vector2, node_navigation : Node2D) -> Vector2 :
	var path : PoolVector2Array = node_navigation.get_simple_path(shooter_pos, target_pos, false)
	if path.size() > 1 :
		return (path[1] - shooter_pos).normalized()
	else : 
		return (target_pos - shooter_pos).normalized()
		
		
func vector_orthogonal(_vector : Vector2) -> Vector2:
	var vector 	: Vector2 = Vector2(0,0)
	var r = randi() %2
	if r == 1 :
		vector.x =   _vector.x
		vector.y = - _vector.y
	else : 
		vector.x = - _vector.x
		vector.y =   _vector.y
			
	return vector
	
func line(_fire_spawn : Vector2) -> float:
	var fire_spawn 	: Vector2 	= _fire_spawn		
	var stop		: int 		= _fire_spawn.x - 1000
	return fire_spawn.x - stop
	
	
	
		
