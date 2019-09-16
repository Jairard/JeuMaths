extends System

class_name BounceSystem

var velocity : Vector2
var pos : Vector2

func _get_used_components() -> Array:
	return [ComponentsLibrary.Position]

func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Position]

func _process_node(dt : float, components : Dictionary) -> void:
	var col_comp = components[ComponentsLibrary.Position] as PositionComponent