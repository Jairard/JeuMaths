extends Node

var data : Dictionary = {}

func get_data(name : String):
	return data[name]

func set_data(exercices : String, _exercices, constants, _constants) -> void:
	data[exercices] = _exercices
	data[constants] = _constants
