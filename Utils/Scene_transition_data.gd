extends Node

var data : Dictionary = {}

func get_data(name : String):
	return data[name]

func set_data(name : String, _data) -> void:
	data[name] = _data
