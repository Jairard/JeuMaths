extends Node

var data : Dictionary = {}

func get_data(name : String):
	return data[name]

func set_data(exercices : String, _exercices, constants, _constants, skin_hero,  _skin_hero) -> void:
	data[exercices] = _exercices
	data[constants] = _constants
	data[skin_hero] = _skin_hero
