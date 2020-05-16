extends Node

class TouchInfos:
	var index: int
	var origin : Vector2
	var position: Vector2
	
	func init(_index : int, _position : Vector2) -> void:
		index = _index
		origin = _position
		position = _position

const null_box : Rect2 = Rect2(0, 0, 0, 0)
var origin_bounding_box : Rect2 = null_box
var bounding_box : Rect2 = null_box
var active_touches : Array = []
var just_released_touches : Array = []

func _process(delta):
	bounding_box = __compute_bounding_box()
	if bounding_box == null_box:
		origin_bounding_box = null_box
	elif origin_bounding_box == null_box:
		origin_bounding_box = bounding_box

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			var infos = TouchInfos.new()
			infos.init(event.index, event.position)
			active_touches.append(infos)
		else:
			var touch = get_touch_infos(event.index)
			if touch != null:
				active_touches.erase(touch)
				just_released_touches.append(touch)
	if event is InputEventScreenDrag:
		var touch = get_touch_infos(event.index)
		if touch != null:
			touch.position = event.position

func get_touch_infos(index : int):
	for touch in active_touches:
		if touch.index == index:
			return touch
	return null

func has_bounding_box() -> bool:
	return bounding_box != null_box

func get_bounding_box() -> Rect2:
	return bounding_box

func get_origin_bouding_box() -> Rect2:
	return origin_bounding_box

func get_just_released_touches() -> Array:
	return just_released_touches

func __compute_bounding_box() -> Rect2:
	if len(active_touches) < 2:
		return null_box

	var first_touch_pos = active_touches[0].position
	var xMin : float = first_touch_pos.x
	var xMax : float = first_touch_pos.x
	var yMin : float = first_touch_pos.y
	var yMax : float = first_touch_pos.y

	for i in range(1, len(active_touches)):
		var touch_pos = active_touches[i].position
		xMin = min(xMin, touch_pos.x)
		xMax = max(xMax, touch_pos.x)
		yMin = min(yMin, touch_pos.y)
		yMax = max(yMax, touch_pos.y)

	return Rect2(xMin, yMin, xMax - xMin, yMax - yMin)
