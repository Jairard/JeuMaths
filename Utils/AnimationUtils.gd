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
	tween.interpolate_property(canvas, "color", Color("#000000"), Color("#00000000"), 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)	
	tween.start()
	return tween
	
func tween_hero_death(node : Node2D, current_pos : Vector2, final_pos : Vector2):
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(node, "position", current_pos, final_pos, 0.3, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.interpolate_callback(node, 1.0, "destroy")		
	tween.start()
	return tween
	

func checkpoint(scene : Node2D, node : Node2D, current_pos : Vector2, final_pos : Vector2):
#	var tween_in = AnimationUtils.tween_fade_in(scene)							#hide hero
#	yield(tween_in, "tween_completed")
	var tween_pos = tween_hero_death(node, current_pos, final_pos)				#set new position for hero
	yield(tween_pos, "tween_completed")
	var anim_in = AnimationUtils.scene_fade_in(scene)							#hide scene
	yield(anim_in, "animation_finished")
	var anim_out = AnimationUtils.scene_fade_out(scene)							#show scene
	yield(anim_out, "animation_finished")
#	var tween_out = AnimationUtils.tween_fade_out(scene)						#show hero
#	yield(tween_out, "tween_completed")

#	AnimationUtils.tween_fade_in(scene)
#	AnimationUtils.scene_fade_in(scene)
#	AnimationUtils.scene_fade_out(scene)	
#	AnimationUtils.tween_fade_out(scene)
#	AnimationUtils.tween_hero_death(node, current_pos, final_pos)

func floating_damage(node : Node2D, dmg : int, _bool : bool):
	if _bool:
		var label = Label.new()
#		label.rect_size(Vector2(200,200))
		label.set_position(Vector2(node.get_position().x + 120, node.get_position().y - 40))
		label.set_scale(Vector2(5,5))
		var damage = dmg
		var parent = node.get_parent()
		parent.add_child(label)
		label.text = ("-" + str(damage))
		var tween : Tween = Tween.new()
		node.add_child(tween)
		
		tween.interpolate_property(label, "modulate", Color("#f1ff08"), Color("#00ffffff"), 0.7, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		tween.start()		

		
		tween.interpolate_property(label, "Scale", Vector2(1,1), Vector2(10,10), 0.7, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		tween.start()
		yield(tween, "tween_completed")
				
		tween.interpolate_property(label, "Scale", Vector2(10,10), Vector2(0.4,0.4), 0.7, Tween.TRANS_SINE, Tween.EASE_IN_OUT)				
		tween.interpolate_callback(label, 1.0, "destroy")	
		tween.start()
#		label.queue_free()
		_bool = false
		yield(tween, "tween_completed")
		return tween


