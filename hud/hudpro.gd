extends Node2D


func _ready():
#	GLOBAL.connect("refreshloot", self, "refresh_item")
	refresh_all()

func refresh_all():
	# TODO: you need to initialize your UI components here !
	pass

func refresh_item(type, value):
	if type == GLOBAL.items.xp :
		$CanvasLayer/MarginContainer2/bars/bar/count/background/xp_progress.value = value
	if type == GLOBAL.items.pv_hero :
		$CanvasLayer/MarginContainer2/bars/bar/count/background/vie_progress.value = value
	if type == GLOBAL.items.degats :
		$CanvasLayer/MarginContainer2/bars/bar/count/background/degats.text = str(value)
	if type == GLOBAL.items.level :
		$CanvasLayer/MarginContainer2/bars/bar/count/background/niveau.text = str(value)
	pass