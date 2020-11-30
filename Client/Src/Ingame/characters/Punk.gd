extends KinematicBody2D

func _ready():
	pass

func deactivate() -> void:
	$Camera2D.clear_current()
	hide()
