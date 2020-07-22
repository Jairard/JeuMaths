extends Node2D


func _ready():
	$gold/AnimationPlayer.play("gold")


func get_gold() -> Label :
	return $gold_label 	as Label

func deactivate_health():
	var i = 1
	while true:
		var nodeName : String = "health" +  str(i)
		var sprite : Sprite = get_node(nodeName)
		if sprite != null:
			sprite.hide()
			i += 1
		else:
			break
