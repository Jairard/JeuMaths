extends Component

class_name MissileComponent

var target_id : int = -1
#var target :  Node2D
#var target_pos  :  Vector2

#func init(_target : Node2D) -> void :
#	target  = _target
#	init_position()
#
#func init_position () :
#	target_pos  = target.position

func init(target : Node) -> void:
	if (target != null):
		set_target_id(target.get_instance_id())
	
func get_target_id() -> int :
	return target_id
	
func get_target() -> Node :
	return instance_from_id(target_id) as Node

func set_target_id(id : int) -> void :
	target_id = id