extends Node

func get_direction_to(target_pos : Vector2, shooter_pos : Vector2, node_navigation : Node2D) -> Vector2 :
	var path : PoolVector2Array = node_navigation.get_simple_path(shooter_pos, target_pos, false)
	if path.size() > 1 :
		return (path[1] - shooter_pos).normalized()
	else : 
		return (target_pos - shooter_pos).normalized()
