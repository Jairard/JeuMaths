extends BaseNetworkMessage

class_name LoginDeniedMessage

enum argument {nickname}
var nickname : String = ""

func _init(args : Array).(args) -> void:
	pass

func _validate(args : Array) -> bool:
	return len(args) == 1 && args[argument.nickname] is String

func _build(args: Array) -> void:
	nickname = args[argument.nickname] 		#args[int(argument.nickname)]
