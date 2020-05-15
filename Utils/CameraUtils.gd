extends Node

var camera : Camera2D = null
const min_zoom = 1.2
const max_zoom = 2.5

func set_camera(_camera: Camera2D) -> void:
	camera = _camera

func set_camera_from_hero(node : Node2D) -> void:
	camera = node.get_node("Camera2D")

func set_offset(pos : Vector2) -> void:
	camera.set_offset(pos)

func get_zoom() -> float:
	return camera.get_zoom().x

func get_zoom_ratio() -> float:
	return (get_zoom() - min_zoom) / (max_zoom - min_zoom)

func set_zoom(zoom : float) -> void:
	zoom = clamp(zoom, min_zoom, max_zoom)
	camera.set_zoom(Vector2(zoom, zoom))

func set_zoom_ratio(ratio: float) -> void:
	set_zoom(min_zoom + ratio * (max_zoom - min_zoom))
