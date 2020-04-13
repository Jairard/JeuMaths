extends Node2D

onready var stats_popup = preload("res://Src/Outgame/Stats_popup.tscn")
onready var shop_popup = preload("res://Src/Outgame/Map_Shop.tscn")
onready var shop = shop_popup.instance()
onready	var stats = stats_popup.instance()
 
var heroNode : Node2D = null

func set_hero_node(node : Node2D) -> void:
	heroNode = node

func _ready():
	$CanvasLayer/HBoxContainer/gold/Label2/AnimationPlayer.play("anim_gold")
	$CanvasLayer.add_child(shop)
	$CanvasLayer.add_child(stats)	

func get_score() -> RichTextLabel:
	return $CanvasLayer/HBoxContainer/score/RichTextLabel			as RichTextLabel

func get_treasure() -> Label :
	return $CanvasLayer/HBoxContainer/gold/Label					as Label

func _on_Button_pressed():
	if shop.is_shown():
		shop.shutdown()
	else:
		shop.init(heroNode)

func _on_Stats_pressed():
	if stats.is_shown():
		stats.shutdown()
	else:
		stats.init(heroNode)
