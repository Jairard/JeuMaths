# Example class of a network message.
# This message's goal is to tell the server we want to login and to give it our nickname + stats

# We inherit from BaseNetworkMessage
extends BaseNetworkMessage

class_name TalkMessage

# Internal member variable: 1 for each instance of the class
enum argument {messageType}	#int
enum message_type {hello, goodbye, tg} #type
var type

# Needed to be able to call LoginRequestMessage.new(args)
# This just forwards the arguments to the _init() method in BaseNetworkMessage
func _init(args : Array).(args) -> void:
	pass

# For this message, we want 1 string argument
func _validate(args : Array) -> bool:
	if len(args) == 1:
		var arg = args[argument.messageType]
		return  arg is int && arg >= 0 && arg < message_type.size()
	return false

# Here we store the argument value in the nickname variable
func _build(args: Array) -> void:
	type = args[argument.messageType]
