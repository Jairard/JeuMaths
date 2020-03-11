extends Node

func tween_hero_collision(node_hero : Node2D) -> void:
	var node = node_hero.get_node("hero_spr")
	var tween = node.get_node("Tween")

	tween.interpolate_property(node, "modulate", Color("#ffffff"), Color("#00ffffff"),0.2, 
	Tween.TRANS_BACK,Tween.EASE_IN_OUT)
	tween.start()

	tween.interpolate_property(node, "modulate", Color("#00ffffff"),Color("#ffffff"),0.2, 
	Tween.TRANS_BACK,Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_completed")
	
	tween.interpolate_property(node, "modulate", Color("#ffffff"), Color("#00ffffff"),0.2, 
	Tween.TRANS_BACK,Tween.EASE_IN_OUT)
	tween.start()

	tween.interpolate_property(node, "modulate", Color("#00ffffff"),Color("#ffffff"),0.2, 
	Tween.TRANS_BACK,Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_completed")

func tween_hero_loot(node_loot : Node2D) -> Tween:
	var node = node_loot.get_node("Sprite")
	var tween = node.get_node("Tween")
	tween.interpolate_property(
	node, "position", node.position,
	Vector2(node.position.x, node.position.y - 500),
	1.5, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	
	tween.interpolate_property(
	node, "scale", Vector2(1,1), Vector2(2, 2),
	1.5, Tween.TRANS_BACK, Tween.EASE_IN_OUT)

	tween.interpolate_property(
	node, "modulate", Color(1.0,1.0,1.0,1.0), Color(1.0,1.0,1.0,0.0),
	0.5, Tween.TRANS_BACK, Tween.EASE_IN_OUT,1)
	
	tween.start()
	return tween

func tween_fade_in(scene : Node2D):
	var tween = Tween.new()
	add_child(tween)
	var canvas = scene.get_node("CanvasModulate")
	canvas.show()
	tween.interpolate_property(canvas, "color", Color("#00000000"), Color("#000000"), 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	return tween

func scene_fade_in(scene : Node2D):
	var rect = scene.get_node("ColorRect")
	var anim = scene.get_node("AnimationPlayer")
	rect.show()
	anim.play("change_scene")
	return anim

func scene_fade_out(scene : Node2D):
	var rect = scene.get_node("ColorRect")
	var anim = scene.get_node("AnimationPlayer")
	rect.show()	
	anim.play("load_scene")
	return anim
	
func tween_fade_out(scene : Node2D):
	var tween = Tween.new()
	add_child(tween)
	var canvas = scene.get_node("CanvasModulate")	
	canvas.show()
	tween.interpolate_property(canvas, "color", Color("#000000"), Color("#00000000"), 0.2, Tween.TRANS_SINE, Tween.EASE_IN_OUT)	
	tween.start()
	return tween




