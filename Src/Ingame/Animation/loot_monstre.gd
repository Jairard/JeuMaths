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
 
	if r >=0 && r<33:
		$loot.frame = 42
		type = GLOBAL.items.xp
		
	if r>=33 && r<66:
		$loot.frame = 44
		type = GLOBAL.items.pv_hero
		
	if r>=66 && r<101:
		$loot.frame = 46
		type = GLOBAL.items.degats
		
	return true
	

