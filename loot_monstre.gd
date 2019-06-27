extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func start(pos) -> bool:
	self.position = Vector2(pos.x,pos.y)
	var r = randi() % 100
	if r >= 66 :
		print(r)
		return false
	else :
		if r >=0 && r<33:
			$loot.frame = 42
			print(r)
		if r>=33 && r<66:
			$loot.frame = 44
			print(r)
		
		return true
	




func _on_loot_monstre_body_entered(body):
	queue_free()
	pass # Replace with function body.
