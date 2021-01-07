extends Node

onready var server = $FakeServer
onready var connection_manager = $FakeConnectionManager

# Create listeners: 'connexion_request_listener' on the FakeConnectionManager node, and 'connection_listener' on self
onready var connexion_request_listener = MessageListener.new(connection_manager, [MessageFactory.MessageType.LoginRequest])
var connection_listener = MessageListener.new(self, [MessageFactory.MessageType.LoginAccepted,
													 MessageFactory.MessageType.ClientDisconnected])

# Register listeners and trigger them
func _ready():
	server.register_listener(connexion_request_listener)
	server.register_listener(connection_listener)

	# The only purpose of the following lines is to simulation received messages
	server.fake_receive_message([MessageFactory.MessageType.LoginAccepted, "toto"])
	server.fake_receive_message([MessageFactory.MessageType.ClientDisconnected, "toto", []])
	server.fake_receive_message([MessageFactory.MessageType.Talk, TalkMessage.message_type.goodbye])
	
	server.fake_receive_message([MessageFactory.MessageType.LoginRequest, "Riri", []])
	server.fake_receive_message([MessageFactory.MessageType.LoginRequest, "Fifi", []])
	server.fake_receive_message([MessageFactory.MessageType.LoginRequest, "Loulou", []])

# Unregister listeners at exit
func _exit_tree():
	server.unregister_listener(connection_listener)
	server.unregister_listener(connexion_request_listener)

# Here we should only received messages listened by 'connection_listener'
func on_network_message(type: int, message) -> void:
	print("Received message of type ", MessageFactory.MessageType.keys()[type], " (", type, "): ", str(message))
