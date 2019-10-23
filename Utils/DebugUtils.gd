extends Node2D

class DebugShape:
	var id : int = 0

	func draw(renderer : CanvasItem) -> void:
		pass

	func id() -> int:
		return id

class Line extends DebugShape:
	var from : Vector2 = Vector2(0, 0)
	var to : Vector2 = Vector2(0, 0)
	var color : Color = Color.black

	func init(_id : int, _from : Vector2, _to : Vector2, _color) -> void:
		id = _id
		from = _from
		to = _to
		color = _color

	func draw(renderer : CanvasItem) -> void:
		if (renderer != null):
			renderer.draw_line(from, to, color) # float width=1.0, bool antialiased=false

class Rect extends DebugShape:
	var area : Rect2 = Rect2(0, 0, 0, 0)
	var outlineColor : Color = Color.black
	var insideColor : Color = Color(0, 0, 0, 0.2)
	var filled = false

	func init(_id : int, _area : Rect2, _outlineColor : Color, _insideColor : Color, _filled : bool) -> void:
		id = _id
		area = _area
		outlineColor = _outlineColor
		insideColor = _insideColor
		filled = _filled

	func draw(renderer : CanvasItem) -> void:
		if (renderer != null):
			if (filled):
				renderer.draw_rect(area, insideColor, true)
			renderer.draw_rect(area, outlineColor, false)

var shapes : Array = []
var counters : Array = []
var last_id : int = 0
var is_enabled : bool = false

func __get_id() -> int:
	var id = last_id
	last_id += 1
	return id

func __add_shape(shape : DebugShape,  frameCount : int) -> void:
	shapes.append(shape)
	counters.append(frameCount)
	update()

func _ready() -> void:
	set_z_index(4096) # To be rendered on top of everything

func set_is_enabled(status : bool) -> void:
	if (is_enabled != status and !status):
		clear()
	is_enabled = status

func add_line(from : Vector2, to : Vector2, color : Color = Color.black, frameCount : int = 1) -> int:
	var id = __get_id()
	var line = Line.new()
	line.init(id, from, to, color)
	__add_shape(line, frameCount)
	return id

func add_rect(area : Rect2, color : Color, frameCount : int = 1, filled : bool = true) -> int:
	var id = __get_id()
	var rect : Rect = Rect.new()
	var insideColor : Color = Color(color.r, color.g, color.b, 0.2)
	rect.init(id, area, color, insideColor, filled)
	__add_shape(rect, frameCount)
	return id

func clear() -> void:
	shapes.clear()
	counters.clear()
	update()

func remove_shape(id : int) -> bool:
	for i in range(len(shapes)):
		var shape = shapes[i]
		if (shape.id() == id):
			shapes.remove(i)
			counters.remove(i)
			update()
			return true
	return false

func _process(delta : float) -> void:
	if (!is_enabled):
		return

	var shapesToRemove : Array = []
	for i in range(len(shapes)):
		var shape : DebugShape = shapes[i]
		var remainingFrameCount : int = counters[i]
		if (remainingFrameCount >= 0):
			remainingFrameCount -= 1
			if (remainingFrameCount < 0):
				shapesToRemove.append(i)
			counters[i] = remainingFrameCount

	for i in ArrayUtils.inverted(shapesToRemove):
		shapes.remove(i)
		counters.remove(i)

	if (len(shapesToRemove) > 0):
		update()

func _draw():
	if (is_enabled):
		for shape in shapes:
			shape.draw(self)

