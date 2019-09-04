extends Component

class_name MissileComponent

var missile = true
#var target :  Node2D
#var target_pos  :  Vector2

#func init(_target : Node2D) -> void :
#	target  = _target
#	init_position()
#
#func init_position () :
#	target_pos  = target.position
	
func get_missile() -> bool :
	return missile
	
func set_missile(value : bool) -> void :
	value = missile