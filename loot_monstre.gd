extends Area2D

var type
signal loot(valeur)

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func start(pos) -> bool:
	self.position = Vector2(pos.x,pos.y)
	var r = randi() % 100
	if r >= 80 :
#		print(r)
		return false
	else :
		if r >=0 && r<20:
			$loot.frame = 42
			type = GLOBAL.items.xp
#			print(r)
		if r>=20 && r<40:
			$loot.frame = 44
			type = GLOBAL.items.pv
		if r>=40 && r<60:
			$loot.frame = 46
			type = GLOBAL.items.armure
		if r>=60 && r<80:
			$loot.frame = 48
			type = GLOBAL.items.degats
		
		return true
	




func _on_loot_monstre_body_entered(body):
	self.emit_signal("loot", type)
	queue_free()
	pass # Replace with function body.
