extends Node2D

var Tcp_Client : StreamPeerTCP = StreamPeerTCP.new()
var pseudo : String = ""

func Client_Connection():
	print("Connecting to server...")
	Tcp_Client.connect_to_host("127.0.0.1", 1337)

	if Tcp_Client.get_connected_port() != 1337:
		print("ERROR with port 1337")
		Tcp_Client = null
		return
	if !Tcp_Client.is_connected_to_host():
		print("ERROR : Fail to connection to Server")
		Tcp_Client = null
		return

#	Tcp_Client.put_var(pseudo)
	print("Connected !")

func _ready():
	Client_Connection()

func _exit_tree():
	print("Closing the server")
	Tcp_Client.disconnect_from_host()

func _process(delta):
	if Tcp_Client == null:
		pass

func _on_Button_pressed():
	pseudo = $LineEdit.get_text()
	print("new pseudo")
	Tcp_Client.put_var(pseudo)
