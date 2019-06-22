extends Sprite

# warning-ignore:unused_signal
signal loot(valeur)

enum type_loot {Armure, Piece_or}
# warning-ignore:unused_class_variable
export(type_loot) var loot_type

var inventaire = [null,null]
#onready var armure = inventaire[0]
#onready var piece_dor = inventaire[1]

func _ready():
	
# warning-ignore:return_value_discarded
	self.connect("loot", get_parent(), "recup_loot")

#func _process(delta):
#	pass


# warning-ignore:unused_argument
func _on_piece_body_entered(body):
	print("touché")
	print("loot : " + str(loot_type))
	self.emit_signal("loot", loot_type)
	if str(loot_type) == "0" :
		inventaire[0] = "armure"
#		armure = "armure" 
#		inventaire[0] = armure
	if str(loot_type) == "1" :
		inventaire[1] = "piece d'or"
#		piece_dor = "piece d'or"
#		inventaire[1] = piece_dor
	print ("inventaire 1 : ", inventaire[0])
	print ("inventaire 2 : ", inventaire[1])
	queue_free()

