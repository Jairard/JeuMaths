# Base class for all network messages.
# It handles the validation & construction of the message.
class_name BaseNetworkMessage

var __is_valid : bool = false

# Messages are always constructed from an Array.
# This array is either extracted from the network or manually build
func _init(args : Array):
	__is_valid = _validate(args)
	if __is_valid:
		_build(args)

# Validation function: TO BE REDEFINED IN MESSAGE EACH CLASS
# Here you can check argument count and type.
# Return true if the arguments are valid, false if it's not the case
func _validate(args : Array) -> bool:
	return false

# Construction function: TO BE REDEFINED IN MESSAGE EACH CLASS
# Here you can extract argument from the Array to local variables.
# See LoginRequestMessage example
func _build(args : Array) -> void:
	pass

# DO NOT REDEFINE THIS METHOD
func is_valid() -> bool:
	return __is_valid
