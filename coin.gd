extends Node2D

signal loot(valeur)

enum type_loot {Armure, Piece_or}

export(type_loot) var loot_type


func _ready():
	self.connect("loot", get_parent().get_node("hero"), "recup_loot")

#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
#	print("touché")
#	print("loot : " + str(loot_type))
	self.emit_signal("loot", loot_type)
	queue_free()
	
