extends Node2D

func _ready():
	$CanvasLayer/KinematicBody2D/AnimationPlayer.play("anim_gold")
	
func get_treasure() -> Label :
	return $CanvasLayer/treasure_value 	as Label
