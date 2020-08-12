extends Node2D

var Tcp_Server : TCP_Server = TCP_Server.new()
var connected_clients : Array = []
var connecting_clients : Array = []
var timer = false

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
	if timer:
		timer = false
		if Tcp_Server.is_connection_available(): 
			var client : StreamPeerTCP = Tcp_Server.take_connection()
			var pseudo = client.get_var()
			connecting_clients.append(client)

			print("A client has connected ! -------- pseudo : ", str(pseudo))
		print("There are currently ", str(len(connected_clients)) ," clients connected")


func _exit_tree():
	print("Closing the server")
	Tcp_Server.stop()

func _handle_client():
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

func handle_client_message(client : StreamPeerTCP):
	pass

func _on_Timer_timeout():
	timer = true
