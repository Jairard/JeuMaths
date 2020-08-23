#extends Node
#
#enum ClientMessage { LoginRequest, Talk, Leave }
#enum ServerMessage { LoginAccepted, LoginDenied, NewClient, NewEntry, ClientDisconnected}
#
#
#class NetworkMessage:
#	var is_server_message : bool = false
#	var type : int = -1
#	var args : Array = []
#	func _init(message : Array, is_server : bool) -> void:
#	 # TODO: découper 'message' en deux:
#	 # - le type (stocker dans la variable 'type')
#	 # - les arguments (stocker dans la variable 'args')
#	 # Doc: regarder la méthode 'slice' de Array
#	 # /!\ 1: bien tester le cas où il n'y a pas d'argument (len(message) ==
#	#1), il y a un piège !
#	# /!\ 2: gérer aussi le cas où le message est complètement vide
#		if len(message) != 0:
#			print("Message null")
#			type = -1
#			args = []
#		else:
#			if len(message) == 1:
#				print("Client ", str(ClientMessage.LoginAccepted), " disconnected")
#				type = -1
#				args = []
#			else:
#				type = message[0]
#				args = message.slice(1, -1)
#	# Fonctions commençant par '__' -> fonctions internes, pas destinées à être
##appelées par l'utilisateur
#	func __validate_client_message_type() -> bool:
#	 # Vérifier que:
#	 # - le type est un int
#	 # - le type correspond à une valeur de l'enum ClientMessage
#		if typeof(type) == TYPE_INT:
#			if type < len(ClientMessage):  
#					return true
#		return false
#	func __validate_server_message_type() -> bool:
#	 # Pareil, mais pour les types de message serveur
#		if typeof(type) == TYPE_INT:
#			if type < len(ServerMessage):  
#					print("validate server message type : ", str(type))
#					return true
##		print("unvalidate server message type : ", str(message.type))
#		return false
#	func __validate_client_message_args() -> bool:
#	 # Vérifie, pour chaque type de message client, s'il y a le bon nombre et
#	#le bon type d'argument
#	 # - LoginRequest: 1 argument de type String
#	 # - Talk: 1 argument de type String
#	 # - Leave: pas d'argument
#		if type == ClientMessage.LoginRequest or type == ClientMessage.Talk:
#			if len(args) == 1 and typeof(args) == TYPE_STRING:
#					print("validate client message args : ", str(args))
#					return true
#		if type == ClientMessage.Leave and len (args) == 0:
#			print("validate client message args : ", str(args))
#			return true
#			print("unvalidate client message args : ", str(args))
#		return false
#	func __validate_server_message_args() -> bool:
#	 # Pareil, mais pour les messages server
#	 # - LoginAccepted: pas d'argument
#	 # - LoginDenied: pas d'argument
#	 # - NewClient: 1 argument de type String
#	 # - NewEntry: 2 arguments de type String
#	 # - NewClient: 1 argument de type String
#		if type == ServerMessage.LoginAccepted or type == ServerMessage.LoginDenied:
#			if len(args) == 0:
#				return true
#				print("validate server message args : ", str(args))
#		if type == ServerMessage.NewClient or type == ServerMessage.NewEntry or type == ServerMessage.ClientDisconnected :
#			if len(args) == 1:
#				print("validate server message args : ", str(args))
#				return true
#		print("unvalidate server message args : ", str(args))
#		return false
#	 # Fonction qui sera appelée dans le constructeur
#	func __validate_message() -> bool:
#	 # Teste is_server_message pour savoir s'il faut appeler
#	#(__validate_client_message_type et __validate_client_message_args) ou
#	#(__validate_server_message_type et __validate_server_message_args)
#		if is_server_message:
#			__validate_server_message_args()
#			__validate_server_message_type()
#		else:
#			__validate_client_message_args()
#			__validate_client_message_type()
#		return false
#
#	func create_message(_type : int, arguments : Array, is_server_message : bool) -> NetworkMessage:
#		_init(ClientMessage.Talk, is_server_message)
#		if __validate_message():
#			return send (StreamPeer)
#		return null
#
#	func send(peer : StreamPeer) -> void:
#		var array : Array = [type, args]
#		peer.put_var(array)
