extends Node2D

export var light_color = Color(1,1,1,1)
export(float) var energy = 3.0
export(bool) var gresille = true

func _ready():
	$Light2D.color = light_color
	$Light2D.energy = energy
#	$Sprite.visible = false

func _process(delta):
	if gresille:
		var rand : float = rand_range(0,100)
		if rand > 75:
			$Light2D.energy = energy + rand_range(-1,1)
