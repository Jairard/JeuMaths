extends Node

# Listener creation and registration is done by 'MessageListenerSandbox'
func on_network_message(type: int, message) -> void:
	var msg : LoginRequestMessage = message as LoginRequestMessage
	print("New login request from '", msg.PlayerID, "'")
