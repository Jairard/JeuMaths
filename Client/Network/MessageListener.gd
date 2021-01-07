extends Node2D

class_name MessageListener

signal network_message

var accepted_message_types : Array = []
const signal_name : String = "network_message"

func _init(target, listened_message_types: Array) -> void:
	accepted_message_types = listened_message_types
	connect(signal_name, target, "on_network_message")

func on_message(message_type: int, message) -> void:
	if accepted_message_types.has(message_type):
		emit_signal(signal_name, message_type, message)
