extends Node

func tween_hero_collision(node_hero : Node2D) -> void:
	var node = node_hero.get_node("Sprite")
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

func rect_fade_in(scene : Node2D):
		var anim = scene.get_node("Control").get_node("AnimationPlayer")
		anim.play("in_rect")
		return anim

func rect_fade_out(scene : Node2D):
	var anim = scene.get_node("Control").get_node("AnimationPlayer")
	anim.play("out_rect")
	return anim

func canvas_fade_in(scene : Node2D):
	var anim = scene.get_node("Control").get_node("AnimationPlayer")
	anim.play("in_scene")
	return anim

func canvas_fade_out(scene : Node2D):
	var anim = scene.get_node("Control").get_node("AnimationPlayer")
	anim.play("out_scene")
	return anim

func tween_hero_death(node : Node2D, current_pos : Vector2, final_pos : Vector2):
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(node, "position", current_pos, final_pos, 0.3, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.interpolate_callback(node, 1.0, "destroy")		
	tween.start()
	return tween


func floating_damage(node : Node2D, dmg : int, _bool : bool, font):
	if _bool:

		var label = NodeUtils.create_label(Vector2(node.get_position().x - 100, node.get_position().y + 150), 
										   Vector2(200,200), Color.black, font, 70,1, Color.black)

		var parent = node.get_parent()
		parent.add_child(label)
		label.text = ("-" + str(dmg))

		var tween : Tween = Tween.new()
		node.add_child(tween)

		tween.interpolate_property(label, "modulate", Color("#f1ff08"), Color("#00ffffff"), 1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		tween.start()	
		yield(tween, "tween_completed")

		_bool = false
		return tween

func ShakeScreen(node : Node2D, amplitude : int):
#	var randomX : int = rand_range(-2,2)
#	var randomY : int = rand_range(-2,2)
	var camera = node.get_node("Camera2D")
	var camera_pos = camera.get_offset()
	node.set_modulate(Color.red)
	camera.set_offset(Vector2(camera_pos.x + amplitude,camera_pos.y + amplitude))
	yield(get_tree().create_timer(.02), "timeout")
	camera.set_offset(Vector2(camera_pos.x - amplitude,camera_pos.y - amplitude))
	yield(get_tree().create_timer(.02), "timeout")
	camera.set_offset(Vector2(camera_pos.x + amplitude,camera_pos.y + amplitude))
	yield(get_tree().create_timer(.02), "timeout")
	camera.set_offset(Vector2(camera_pos.x - amplitude,camera_pos.y - amplitude))
	yield(get_tree().create_timer(.02), "timeout")
	camera.set_offset(camera_pos)
	node.set_modulate(Color.white)
