extends Area2D


func _ready():
	pass
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	GLOBAL.treasure += 1
	GLOBAL.emit_signal("treasure", GLOBAL.treasure)
	queue_free()
	pass # Replace with function body.
