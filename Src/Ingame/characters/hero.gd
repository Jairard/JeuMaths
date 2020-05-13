extends KinematicBody2D

func _ready():
	pass

func deactivate() -> void:
	$Camera2D.clear_current()
	hide()
	
func set_camera_offset(node : Node2D, pos : Vector2) -> void:
	node.get_node("Camera2D").set_offset(pos)


func set_camera_zoom(node : Node2D, pos : Vector2) -> void:
	node.get_node("Camera2D").set_zoom(pos)
