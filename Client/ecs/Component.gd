extends Object

class_name Component

var id : int
var tag : String = ""
var was_ghost = false

func get_node() -> Node:
	return instance_from_id(id) as Node

func __set_object_id(newId : int) -> void:
	id = newId

func get_id() -> int:
	return id

func get_tag() -> String:
	return tag;

func has_tag() -> bool:
	return !tag.empty()

func was_ghost() -> bool:
	return was_ghost

func __mark_as_ghost() -> void:
	was_ghost = true

func __set_tag(_tag : String) -> void:
	tag = _tag

func _on_destroyed() -> void:
	pass

func draw_debug_line_to(to : Vector2, color : Color = Color.black, frameCount : int = 1) -> int:
	return draw_debug_line(Vector2(0, 0), to, color, frameCount)

func draw_debug_line(from : Vector2, to : Vector2, color : Color = Color.black, frameCount : int = 1) -> int:
	var node : Node2D = get_node() as Node2D
	if (node != null):
		from = node.to_global(from)
		to = node.to_global(to)
	return DebugUtils.add_line(from, to, color, frameCount)

func draw_debug_rect(area : Rect2, color : Color, frameCount : int = 1, filled : bool = true) -> int:
	var node : Node2D = get_node() as Node2D
	if (node != null):
		area.position = node.to_global(area.position)
		area.size *= node.get_scale()
		area.end = area.position + area.size
	return DebugUtils.add_rect(area, color, frameCount, filled)
