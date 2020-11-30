# Example class of a network message.
# This message's goal is to tell the server we want to login and to give it our nickname + stats

# We inherit from BaseNetworkMessage
extends BaseNetworkMessage

class_name LoginRequestMessage

# Internal member variable: 1 for each instance of the class
enum argument {nickname, stats}
var nickname : String = ""
var stats : Array = []

# Needed to be able to call LoginRequestMessage.new(args)
# This just forwards the arguments to the _init() method in BaseNetworkMessage
func _init(args : Array).(args) -> void:
	pass

# For this message, we want 1 string argument
func _validate(args : Array) -> bool:
	return len(args) == 2 && args[argument.nickname] is String && args[argument.stats] is Array

# Here we store the argument value in the nickname variable
func _build(args: Array) -> void:
	nickname = args[argument.nickname] 		#args[int(argument.nickname)]
	stats = args[argument.stats] 
