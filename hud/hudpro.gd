extends Node2D







func _ready():
	GLOBAL.connect("refreshloot", self, "refresh_item")
	

func refresh_item(type, value):
	if type == "xp" : 
		$CanvasLayer/MarginContainer2/bars/bar/count/background/xp_progress.value = value
	if type == "pv" : 
		$CanvasLayer/MarginContainer2/bars/bar/count/background/vie_progress.value = value
	if type == "degats" : 
		$CanvasLayer/MarginContainer2/bars/bar/count/background/degats.text = str(value)
	if type == "level" : 
		$CanvasLayer/MarginContainer2/bars/bar/count/background/niveau.text = str(value)

	
	
	
	
#func _process(delta):
#	pass




