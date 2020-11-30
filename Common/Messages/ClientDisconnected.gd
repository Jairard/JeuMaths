extends BaseNetworkMessage

class_name ClientDisconnectedMessage

enum argument {nickname, stats}
var nickname : String = ""
var stats : Array = []

func _init(args : Array).(args) -> void:
	pass

func _validate(args : Array) -> bool:
	return len(args) == 2 && args[argument.nickname] is String && args[argument.stats] is Array

func _build(args: Array) -> void:
	nickname = args[argument.nickname] 		#args[int(argument.nickname)]
	stats = args[argument.stats] 
