extends KinematicBody2D

#enum type_rain  {
#	health_bonus = 0
#	health_malus = 1
#	coin = 2
#	}
#
#export (type_rain) var rain_type


func _process(delta):
	if self.position.y >= 540 :
		queue_free()

#func start(pos, type):
#	self.position = pos
#	rain_type = type
#	if rain_type == 0 :
#		$Sprite.modulate = Color (0,0,1)
#	if rain_type == 1 :
#		$Sprite.modulate = Color (1,0,0)
#	if rain_type == 2 :
#		$Sprite.modulate = Color (255,215,0)

