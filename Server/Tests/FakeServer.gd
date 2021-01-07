extends Node

# Nothing really interesting here, just keeping a list of listeners and triggering them
# Only for test purposes
var message_listeners : Array = []

func register_listener(listener) -> void:
	message_listeners.append(listener)

func unregister_listener(listener) -> void:
	message_listeners.erase(listener)

func fake_receive_message(msg : Array) -> void:
	var artefact = MessageFactory.create_message_from_network(msg)
	if artefact.is_valid():
		for listener in message_listeners:
			listener.on_message(artefact.type, artefact.message)
