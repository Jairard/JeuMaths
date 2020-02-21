extends Node2D

onready var stats_timer = $CanvasLayer/Score/Timer
onready var stats_popup = preload("res://Src/Outgame/Stats_popup.tscn")

func _ready():
	$CanvasLayer/KinematicBody2D/AnimationPlayer.play("anim_gold")

func get_score() -> RichTextLabel:
	return $CanvasLayer/Score										as RichTextLabel

func get_treasure() -> Label :
	return $CanvasLayer/HBoxContainer2/MarginContainer/treasure 	as Label

func _on_Button_pressed():
	get_tree().change_scene(FileBankUtils.loaded_scenes["shop"])
	

func _on_Stats_pressed():
	print ("pause")
	get_tree().paused = true
	var stats = stats_popup.instance()
	add_child(stats)
	stats_timer.start()

func _on_Timer_timeout():
	get_tree().paused = false
	
