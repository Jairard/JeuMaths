extends Node2D

onready var stats_popup = preload("res://Src/Outgame/Stats_popup.tscn")
onready var shop_popup = preload("res://Src/Outgame/Map_Shop.tscn")


func _ready():
	$CanvasLayer/KinematicBody2D/AnimationPlayer.play("anim_gold")

func get_score() -> RichTextLabel:
	return $CanvasLayer/Score										as RichTextLabel

func get_treasure() -> Label :
	return $CanvasLayer/HBoxContainer2/MarginContainer/treasure 	as Label

func _on_Button_pressed():
#	get_tree().change_scene(FileBankUtils.loaded_scenes["shop"])
	var shop = shop_popup.instance()
	$CanvasLayer.add_child(shop)
	shop.show()
	get_tree().paused = true	
	yield(get_tree().create_timer(20), 'timeout')
	shop.hide()
	get_tree().paused = false

func _on_Stats_pressed():
	var stats = stats_popup.instance()
	$CanvasLayer.add_child(stats)
	stats.show()
	get_tree().paused = true	
	yield(get_tree().create_timer(2), 'timeout')
	stats.hide()
	get_tree().paused = false
