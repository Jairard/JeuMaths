extends Node

onready var server = get_parent().get_node("FakeServer")

# Create our own listener
var talk_listener = MessageListener.new(self, [MessageFactory.MessageType.Talk])

# Register the listener and simulation a message reception
func _ready():
	server.register_listener(talk_listener)
	server.fake_receive_message([MessageFactory.MessageType.Talk, TalkMessage.message_type.goodbye])

# Unregister the listener
func _exit_tree():
	server.unregister_listener(talk_listener)

# Called when a TalkMessage is received
func on_network_message(type: int, message) -> void:
	var msg : TalkMessage = message as TalkMessage
	print("Someone said '", TalkMessage.message_type.keys()[msg.type], "' (", msg.type, ")")
