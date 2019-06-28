extends Node2D







func _ready():
	GLOBAL.connect("refreshloot", self, "refresh_item")
	

func refresh_item(type, value):
	if type == "xp" : 
		$CanvasLayer/ColorRect/MarginContainer/HBoxContainer/XP.text = str(value)
	if type == "pv" : 
		$CanvasLayer/ColorRect/MarginContainer/HBoxContainer/vie.text = str(value)
	if type == "level" : 
		$CanvasLayer/ColorRect/MarginContainer/HBoxContainer/level.text = str(value)
	if type == "degats" : 
		$CanvasLayer/ColorRect/MarginContainer/HBoxContainer/degats.text = str(value)

	
	
	
	
#func _process(delta):
#	pass




