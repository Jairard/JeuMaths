extends Node

var Tcp_Client : StreamPeerTCP = StreamPeerTCP.new()
var is_in_chat_room = false
enum app_status {waiting_for_server, waiting_for_login, logged}
var status = app_status.waiting_for_server
var message_listeners : Array = []
