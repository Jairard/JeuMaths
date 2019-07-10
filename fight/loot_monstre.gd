extends Area2D

var type
signal loot(valeur)

func _ready():
	connect("loot", GLOBAL, "item_loot")
	pass
	

#func _process(delta):
#	pass


func start(pos) -> bool:
	self.position = Vector2(pos.x,pos.y)
	randomize()
	var r = randi() % 100
#	print(r)
	if r >= 90 :
		return false
	else :
		if r >=0 && r<30:
			$loot.frame = 42
			type = GLOBAL.items.xp
			
		if r>=30 && r<60:
			$loot.frame = 44
			type = GLOBAL.items.pv_hero
			
		if r>=60 && r<90:
			$loot.frame = 46
			type = GLOBAL.items.degats
		
		return true
	




func _on_loot_monstre_body_entered(body):
	self.emit_signal("loot", type)
	queue_free()
	pass # Replace with function body.
