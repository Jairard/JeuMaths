extends BaseNetworkMessage

class_name LoginAcceptedMessage

enum argument {nickname}
var nickname : String = ""

func _init(args : Array).(args) -> void:
	pass

func _validate(args : Array) -> bool:
	return len(args) == 1 && args[argument.nickname] is String or false

func _build(args: Array) -> void:
	#renvoyer l'id
	nickname = args[argument.nickname] 		#args[int(argument.nickname)]
