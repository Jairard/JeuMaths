extends Component

class_name MissileComponent

var target_id : int = -1

func init(target : Node) -> void:
	if (target != null):
		set_target_id(target.get_instance_id())
	
func get_target_id() -> int :
	return target_id
	
func get_target() -> Node :
	return instance_from_id(target_id) as Node

func set_target_id(id : int) -> void :
	target_id = id