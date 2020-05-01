extends Node2D

onready var rect = $Control/ColorRect

var stats : Dictionary = {}
const init_stats : Dictionary =  {
									"damage":15, "health":70,
									"treasure":0,"good_answer":0,
									"wrong_answer":0,"victories":0,"defeats":0,
									"health_max":70, "scene_counter":0
									} 	


var notions_show : Array = ["_4_Operations/Control", "Literal_calculation/Control", "Fraction/Control", "Arithmetic/Control",
					"Conversion/Control", "Percentage/Control"]#, "Power", "Fonction"]

var notions_press : Array = ["_4_Operations", "Literal_calculation", "Fraction", "Arithmetic",
					"Conversion", "Percentage"]#, "Power", "Fonction"]

var lessons_path : Array = ["_4_Operations/Control/HBoxContainer/questions_intergers/addition_entiers", 
"_4_Operations/Control/HBoxContainer/questions_intergers/soustraction_entiers", 
"_4_Operations/Control/HBoxContainer/questions_intergers/multiplication_entiers",
 "_4_Operations/Control/HBoxContainer/questions_intergers/division_entiers", 
"_4_Operations/Control/HBoxContainer/questions_floats/addition_décimaux", 
"_4_Operations/Control/HBoxContainer/questions_floats/soustraction_décimaux",
"_4_Operations/Control/HBoxContainer/questions_floats/multiplication_décimaux",
"_4_Operations/Control/HBoxContainer/questions_floats/division_décimaux", 
"_4_Operations/Control/HBoxContainer/questions_relatives/addition_relatifs", 
"_4_Operations/Control/HBoxContainer/questions_relatives/soustraction_relatifs",
 "_4_Operations/Control/HBoxContainer/questions_relatives/multiplication_relatifs",
"_4_Operations/Control/HBoxContainer/questions_relatives/division_relatifs",
 "_4_Operations/Control/HBoxContainer/questions_priorities/priorités_sans_parenthèses",
"_4_Operations/Control/HBoxContainer/questions_priorities/priorités_avec_parenthèses",
"Literal_calculation/Control/HBoxContainer/Use/tester_valeur",
"Literal_calculation/Control/HBoxContainer/Use/ax+b=c",
"Literal_calculation/Control/HBoxContainer/Use/ax+b=cxd",
"Literal_calculation/Control/HBoxContainer/Reduce/réduction_sans_parenthèses",
"Literal_calculation/Control/HBoxContainer/Reduce/réduction_avec_parenthèses",
"Literal_calculation/Control/HBoxContainer/Distribute/développement_simple",
"Literal_calculation/Control/HBoxContainer/Distribute/développement_double",
"Literal_calculation/Control/HBoxContainer/Distribute/factorisation",
"Literal_calculation/Control/HBoxContainer/Distribute/a²-b²=(a-b)(a+b)",
"Fraction/Control/HBoxContainer/fraction_additions_oustraction/même_dénominateur",
"Fraction/Control/HBoxContainer/fraction_additions_oustraction/dénominateur_multiples",
"Fraction/Control/HBoxContainer/fraction_additions_oustraction/cas_général",
"Fraction/Control/HBoxContainer/fraction_multiplication_division/fraction_multiplication",
"Fraction/Control/HBoxContainer/fraction_multiplication_division/fraction_division",
"Arithmetic/Control/HBoxContainer/arithmetic/décomposition",
"Arithmetic/Control/HBoxContainer/arithmetic/fraction_irréductible",
"Conversion/Control/HBoxContainer/Conversion/conversion_longueurs",
"Conversion/Control/HBoxContainer/Conversion/conversion_aires",
"Conversion/Control/HBoxContainer/Conversion/conversion_volumes",
"Percentage/Control/HBoxContainer/Percentage/appliquer_pourcentages",
"Percentage/Control/HBoxContainer/Percentage/trouver_pourcentages_simple",
"Percentage/Control/HBoxContainer/Percentage/trouver_pourcentages"]

var lessons_list : Array = []
var lessons : Array = []

func itemlist(_lessons : Array) -> void:
	for i in _lessons:
		var txt = i.split("/")
		if lessons.count(txt[4]) == 0:
			$ItemList.add_item(txt[4])
			lessons += [txt[4]]
			print (lessons)

func check_click():
	for i in lessons_path:
		if get_node(i).pressed:
			print ("in")
			if lessons_list.count(i) == 0 or len(lessons_list) == 0:
				lessons_list += [i]
				itemlist(lessons_list)

func _input(event):
#	if event.is_action_released("clic"):
#		check_click()
	if (event is InputEventMouseButton && event.pressed):
		yield(get_tree().create_timer(.1), "timeout")
		check_click()

func show_notion(notions_show : Array, lesson : String) -> void:
	for i in notions_show:
		if i == lesson:
			get_node(i).show()
		else:
			get_node(i).hide()

func press_notion(notions_press : Array,  lesson : String) -> void:
	for i in notions_press:
		if i == lesson:
			get_node(i).pressed = true
		else:
			get_node(i).pressed = false


func _ready(): 

	var anim_rect = AnimationUtils.rect_fade_in(self)
	yield(anim_rect, "animation_finished")
	rect.hide()

	if FileBankUtils.loaded_heroes_stats != null:
		stats = FileBankUtils.loaded_heroes_stats.duplicate(true)

	add_map_option_()
	add_fight_option()
	add_featured_option()
	add_unused_option()


func add_map_option_() -> void:
	$Control_Option/Option_map.set_text("Maps")	
	$Control_Option/Option_map.add_separator()
	$Control_Option/Option_map.add_item("tuto")
	$Control_Option/Option_map.add_item("fire")
	$Control_Option/Option_map.add_item("water")
	$Control_Option/Option_map.add_item("fire_0")
	$Control_Option/Option_map.add_item("water_0")
	$Control_Option/Option_map.add_item("upside_down")
	
func add_fight_option() -> void:
	$Control_Option/Option_fight.set_text("Fights")
	$Control_Option/Option_fight.add_separator()
	$Control_Option/Option_fight.add_item("fight_1")
	$Control_Option/Option_fight.add_item("fight_2")	

func add_featured_option() -> void:
	$Control_Option/Option_featured_scenes.set_text("Featured")
	$Control_Option/Option_featured_scenes.add_separator()
	$Control_Option/Option_featured_scenes.add_item("rewards")	
	$Control_Option/Option_featured_scenes.add_item("shop")
	$Control_Option/Option_featured_scenes.add_item("death")
	
func add_unused_option() -> void:
	$Control_Option/Option_unused_scenes.set_text("Unused")
	$Control_Option/Option_unused_scenes.add_separator()
	$Control_Option/Option_unused_scenes.add_item("create_hero")	


func get_stats(pseudo : String) -> Dictionary:
	for _pseudo in stats.keys():
		if _pseudo == pseudo:
			return { "new_hero" : false, "stats" : stats[_pseudo]}

	var new_stats = init_stats.duplicate(true)
	stats[pseudo] = new_stats
	return {"new_hero" : true, "stats" : new_stats}


func load_stats():
	var pseudo : String = $TileMap/pseudo.get_text()
	var stats_hero = get_stats(pseudo)
	FileBankUtils.init_stats(stats_hero["stats"], pseudo)



func _on_Option_map_item_selected(id):
	load_stats()
	match id:
		1:
			Fade.change_scene(FileBankUtils.loaded_scenes["playing_map"][0]["map_tuto"])
		2:
			Fade.change_scene(FileBankUtils.loaded_scenes["playing_map"][1]["map_fire"])
		3:
			Fade.change_scene(FileBankUtils.loaded_scenes["map_water"])
		4:
			Fade.change_scene(FileBankUtils.loaded_scenes["playing_map"][2]["map_fire_0"])
		5:
			Fade.change_scene(FileBankUtils.loaded_scenes["map_water_0"])
		6:
			Fade.change_scene(FileBankUtils.loaded_scenes["upside_down"])

func _on_Option_fight_item_selected(id):
	load_stats()
	match id:
		1:
			Fade.change_scene(FileBankUtils.loaded_scenes["map_fight_1"])
		2:
			Fade.change_scene(FileBankUtils.loaded_scenes["map_fight_2"])

func _on_Option_featured_scenes_item_selected(id):
	load_stats()
	match id:
		1:
			Fade.change_scene(FileBankUtils.loaded_scenes["rewards"])
		2:
			Fade.change_scene(FileBankUtils.loaded_scenes["shop"])
		3:
			Fade.change_scene(FileBankUtils.loaded_scenes["death"])

func _on_Option_unused_scenes_item_selected(id):
	load_stats()
	match id:
		1:
			Fade.change_scene(FileBankUtils.loaded_scenes["create_hero"])
	
func _on_Conversion_pressed():
	show_notion(notions_show, "Conversion/Control")
	press_notion(notions_press, "Conversion")

func _on_Percentage_pressed():
	show_notion(notions_show, "Percentage/Control")
	press_notion(notions_press, "Percentage")


func _on_Arithmetic_pressed():
	show_notion(notions_show, "Arithmetic/Control")
	press_notion(notions_press, "Arithmetic")


func _on_Fraction_pressed():
	show_notion(notions_show, "Fraction/Control")
	press_notion(notions_press, "Fraction")


func _on_Literal_calculation_pressed():
	show_notion(notions_show, "Literal_calculation/Control")
	press_notion(notions_press, "Literal_calculation")


func _on_4_Operations_pressed():
	show_notion(notions_show, "_4_Operations/Control")
	press_notion(notions_press, "_4_Operations")

func _on_Fonction_pressed():
	pass


func _on_Power_pressed():
	pass
