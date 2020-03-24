extends Node2D

enum type_class {Tank, Assassin, Mage}
export (type_class) var class_type


func _ready():
	var anim = AnimationUtils.scene_fade_out(self)
	yield(anim, "animation_finished")
	var tween = AnimationUtils.canvas_fade_out(self)
	yield(tween, "tween_completed")


#func _process(delta):
#	pass


func _on_Button_pressed():
	FileBankUtils.loaded_scenes["playing_map"][1]["map_fire"]



func _on_Tank_pressed():
	class_type == type_class.Tank
	print("Tank")
#		hero = Tank
	pass


func _on_Assassin_pressed():
	class_type == type_class.Assassin
	print("Assassin")
	pass


func _on_Mage_pressed():
	class_type == type_class.Mage
	print("Mage")
	pass
