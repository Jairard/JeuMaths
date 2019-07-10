extends Node2D

func set_xp(value):
	$CanvasLayer/MarginContainer2/bars/bar/count/background/xp_progress.value = value
		
func set_pv_hero(value):
	$CanvasLayer/MarginContainer2/bars/bar/count/background/vie_progress.value = value
	$CanvasLayer/MarginContainer2/bars/bar/count/background/pv.text = str(value)
		
func set_degats(value):
	$CanvasLayer/MarginContainer2/bars/bar/count/background/degats.text = str(value)
		
func set_level(value):
	$CanvasLayer/MarginContainer2/bars/bar/count/background/niveau.text = str(value)
