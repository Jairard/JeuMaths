extends Node

# Enum for all the message types
enum MessageType { LoginRequest, LoginDenied, ClientDisconnected, LoginAccepted, Talk}

class MessageArtefact:
	var type : int = -1
	var message = null

	func _init(_type : int, _message) -> void:
		type = _type
		message = _message

	func is_valid() -> bool:
		return message != null

var invalid_artefact = MessageArtefact.new(-1, null)

# This function must be called when an object is received from the network.
# It will convert it to an instance of a message class.
# Network messages should look like [<message_type>, <arg_0>, <args_1>, ...]
func create_message_from_network(message : Array):
	# Check that we have the message type as the first element
	if len(message) < 1 || !(message[0] is int):
		return invalid_artefact

	var type = message[0]
	# Get the message arguments as an Array
	var args = __get_message_args(message)

	# Try to build the corresponding message
	var msg = __create_message(type, args)
	if msg == null:
		return invalid_artefact
	return MessageArtefact.new(type, msg)

# This function must be called when we want to send an object to the network
# The result is either an empty array is the provided input are not valid,
# or a non-empty array so can be sent through a peer.
func create_message_to_send(type : int, args : Array) -> Array:
	# Try to build the corresponding message
	# We will not use the result, it's just to check the validity
	if __create_message(type, args) == null:
		return []
	return [type] + args

# This is an internal function that should not be called from outside this file.
# It is the core od the factory: it creates an instance of the message corresponding
# to the given type and arguments.
# It returns null is the type is unknown or if the message is not valid.
func __create_message(type : int, args : Array):
	var msg = null
	
	match type:
		MessageType.LoginRequest:
			msg = LoginRequestMessage.new(args)
		MessageType.LoginDenied:
			msg = LoginDeniedMessage.new(args)
		MessageType.LoginAccepted:
			msg = LoginAcceptedMessage.new(args)
		MessageType.ClientDisconnected:
			msg = ClientDisconnectedMessage.new(args)
		MessageType.Talk:
			msg = TalkMessage.new(args)
			
		# Other message types here ...

	# If the message type does not correspond to a known message (msg == null)
	# or if the arguments were not valid (!msg.is_valid()), we return an invalid artefact
	if msg == null || !msg.is_valid():
		return null

	# Else we have successfully built the message !
	return msg

func __get_message_args(message : Array) -> Array:
	return [] if len(message) < 2 else message.slice(1, len(message) - 1)
