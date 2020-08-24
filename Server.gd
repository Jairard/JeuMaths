extends Node2D

var Tcp_Server : TCP_Server = TCP_Server.new()
var connected_clients : Array = []
var connecting_clients : Array = []

func Server_Start_Listening():
	print("Starting the server...")
	var success = Tcp_Server.listen(1337,"*")
	if success != OK:
		print ("ERROR listening : ",success)
		return

	print("The server is waiting for clients")

func _ready():
	Server_Start_Listening()

func _process(delta):
	if Tcp_Server.is_connection_available(): 
		var client : StreamPeerTCP = Tcp_Server.take_connection()
		var pseudo = client.get_var()
		connecting_clients.append(client)

		print("A client has connected ! -------- pseudo : ", str(pseudo))

func _exit_tree():
	print("Closing the server")
	Tcp_Server.stop()

func handle_clients():
	var clients_to_remove : Array = []
	for client in connecting_clients:
		match(client.get_status()):
			StreamPeerTCP.STATUS_NONE:
				clients_to_remove.append(client)
				print("Client disconnected after trying to connect")
			StreamPeerTCP.STATUS_CONNECTING:
				pass
			StreamPeerTCP.STATUS_CONNECTED:
				clients_to_remove.append(client)
				connected_clients.append(client)
			StreamPeerTCP.STATUS_ERROR:
				clients_to_remove.append(client)
				print("An ERROR occured while trying to connect")

	for client in clients_to_remove:
		connecting_clients.erase(client)

	clients_to_remove = []
	for client in connected_clients:
		match(client.get_status()):
			StreamPeerTCP.STATUS_NONE:
				clients_to_remove.append(client)
				print("Client disconnected")
			StreamPeerTCP.STATUS_CONNECTING:
				print("A connected client is trying to connect what the fuck")
			StreamPeerTCP.STATUS_CONNECTED:
				handle_client_message(client)
			StreamPeerTCP.STATUS_ERROR:
				clients_to_remove.append(client)
				print("A dark error happened the client is fucking ahahahah")

	for client in clients_to_remove:
		connected_clients.erase(client)

	print("They are currently ", str(len(connecting_clients)), " clients connecting and ", str(len(connected_clients)) ," clients connected")

func handle_client_message(client : StreamPeerTCP):
	if client.get_available_bytes() < 1:
		return
	var message : Protocol.NetworkMessage = Protocol.create_client_message_from_network(client.get_var())
	if message == null:
		return
	print("Mesage received")
	match message.type:
		Protocol.ClientMessage.LoginRequest:
			var answer : Protocol.NetworkMessage = Protocol.create_server_message(Protocol.ServerMessage.LoginAccepted)
			answer.send(client)
			print("LoginAccepted send to client")

func _on_Timer_timeout():
	handle_clients()
