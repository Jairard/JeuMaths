extends Node2D





func _ready():
	GLOBAL.connect("refreshloot", self, "refresh_item2")
	pass 
	
	
	
#func _process(delta):
#	pass


func refresh_item2(type, value) :
	if type == GLOBAL.items.pv_ennemy :
		$CanvasLayer/pv_ennemy/MarginContainer/life_ennemy.value = value
	if type == GLOBAL.items.pv_hero :
		$CanvasLayer/pv_hero/MarginContainer/life_hero.max_value = value
		$CanvasLayer/pv_hero/MarginContainer/life_hero.value = value
		$CanvasLayer/HBoxContainer4/Label.text = str(value)
	if type == GLOBAL.items.degats :
		$CanvasLayer/valeur_degats/MarginContainer/valeur_degat.text = str(value)
	if type == GLOBAL.items.xp :
		$CanvasLayer/HBoxContainer/MarginContainer/xp.value = value
	if type == GLOBAL.items.level :
		$CanvasLayer/HBoxContainer2/MarginContainer/level.text = str(value)
		
	
