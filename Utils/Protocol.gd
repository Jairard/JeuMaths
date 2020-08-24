extends Node

enum ClientMessage { LoginRequest, Talk, Leave }
enum ServerMessage { LoginAccepted, LoginDenied, NewClient, NewEntry, ClientDisconnected}


class NetworkMessage:
	var type : int = -1
	var args : Array = []
	func _init(message : Array) -> void:
		if len(message) != 0:
			type = -1
			args = []
		else:
			type = message[0]
			args = message.slice(1, -1)
			if !__validate_message():
				type = -1
				args = []

	func is_valid() -> bool:
		if type != -1:
			return true
		return false

	func __validate_message() -> bool:
		return __validate_message_args() and __validate_message_type()

	func __validate_message_type() -> bool:
		return false

	func __validate_message_args() -> bool:
		return false

	func send(peer : StreamPeer) -> void:
		peer.put_var([type] + args)

class ClientNetworkMessage extends NetworkMessage:
	func _init(message : Array).(message) -> void:
		pass

	func __validate_message_type() -> bool:
		if typeof(type) == TYPE_INT:
			if type < len(ClientMessage):  
					return true
		return false

	func __validate_message_args() -> bool:
		if type == ClientMessage.LoginRequest or type == ClientMessage.Talk:
			if len(args) == 1 and typeof(args) == TYPE_STRING:
					return true
		if type == ClientMessage.Leave and len (args) == 0:
			return true
		return false

class ServerNetworkMessage extends NetworkMessage:
	func _init(message : Array).(message) -> void:
		pass

	func __validate_message_type() -> bool:
		if typeof(type) == TYPE_INT:
			if type < len(ServerMessage):  
					return true
		return false

	func __validate_message_args() -> bool:
		if type == ServerMessage.LoginAccepted or type == ServerMessage.LoginDenied:
			if len(args) == 0:
				return true
		if type == ServerMessage.NewClient or type == ServerMessage.NewEntry or type == ServerMessage.ClientDisconnected :
			if len(args) == 1:
				return true
		return false


func create_server_message(_type : int, arguments : Array = []) -> NetworkMessage:
	var message : NetworkMessage = ServerNetworkMessage.new([_type] + arguments)
	if message.is_valid():
		return message
	return null


func create_client_message(_type : int, arguments : Array = []) -> NetworkMessage:
	return create_client_message_from_network([_type] + arguments)

func create_client_message_from_network(_message : Array = []) -> NetworkMessage:
	var message : NetworkMessage = ClientNetworkMessage.new(_message)
	if message.is_valid():
		return message
	return null
















