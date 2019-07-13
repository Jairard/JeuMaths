extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_vie_pressed():
	print ("vie")
	queue_free()
	GLOBAL.pv_hero_max += 10
	GLOBAL.pv_hero += 10
	pass # Replace with function body.


func _on_degats_pressed():
	print ("degats")
	queue_free()
	GLOBAL.degats += 10
	pass # Replace with function body.
