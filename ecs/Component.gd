extends Object

class_name Component

var id : int

func get_node() -> Node:
	return instance_from_id(id) as Node

func __set_object_id(newId : int) -> void:
	id = newId
