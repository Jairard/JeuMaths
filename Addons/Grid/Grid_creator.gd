tool
extends EditorPlugin

func _enter_tree() -> void:					#add object on the scene
	add_custom_type("Grid_creator",  "Node2D", preload("Grid.gd"), 
					preload("alienYellow_square.png"))

func _exit_tree() -> void:					#delete object on the scene
	remove_custom_type("Grid_creator")
