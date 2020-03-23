extends Node2D

func _ready():
	var anim = AnimationUtils.scene_fade_out(self)
	yield(anim, "animation_finished")
	var tween = AnimationUtils.canvas_fade_out(self)
	yield(tween, "tween_completed")

func _on_reset_button_pressed():
	FileBankUtils.loaded_scenes["playing_map"][1]["map_fire"]
