extends Node2D

func _ready():
	$gold/AnimationPlayer.play("gold")

func get_gold() -> Label :
	return $gold_label 	as Label
