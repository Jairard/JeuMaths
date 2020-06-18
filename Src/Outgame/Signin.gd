extends Node2D

onready var rect = $Control/ColorRect

var stats : Dictionary = {}
const init_stats : Dictionary =  {
									"damage":0, "health":70,
									"treasure":150,"good_answer":0,
									"wrong_answer":0,"victories":0,"defeats":0,
									"health_max":70, "scene_counter":0
									}

var constants : Dictionary = {"addition_fraction_simple" : 0, "soustraction_fraction_simple" : 1,
"addition_fraction_multiple" : 2, "soustraction_fraction_multiple" : 3, "addition_fraction_general" : 4,
"soustraction_fraction_general" : 5, "multiplication_fraction" : 6, "division_fraction" : 7, 
"fraction_irreductible" : 8,"calcul_valeur" : 9, "tester_egalite_simple" : 10, "tester_egalite_general" : 11,
"reduire_simple" : 12, "reduire_parentheses" : 13, "developpement_simple" : 14,
"developpement_double" : 15, "factorisation_simple" : 16, "factorisation_id_rem" : 17,
"addition_entiers" : 18, "soustraction_entiers" : 19, "multiplication_entiers" : 20,
"division_entiers" : 21, "addition_decimaux" : 22, "soustraction_decimaux" : 23,
"multiplication_decimaux" : 24, "division_decimaux" : 25, "addition_relatifs" : 26,
"soustraction_relatifs" : 27, "multiplication_relatifs" : 28, "division_relatifs" : 29,
"appliquer_pourcentage" : 30, "trouver_pourcentage_simple" : 31, "trouver_pourcentage" : 32,
"priorites_simple" : 33, "priorites_parentheses" : 34, "decomposition" : 35}

var notions_show : Array = ["VBoxContainer/_4_Operations/Control", "VBoxContainer/Literal_calculation/Control", 
							"VBoxContainer/Fraction/Control", "VBoxContainer/Arithmetic/Control",
							"VBoxContainer/Percentage/Control"]#, "Conversion", "Power", "Fonction"]

var notions_press : Array = ["VBoxContainer/_4_Operations", "VBoxContainer/Literal_calculation", 
							 "VBoxContainer/Fraction", "VBoxContainer/Arithmetic",
							 "VBoxContainer/Percentage"]#, "Conversion", "Power", "Fonction"]

var lessons_path : Array = ["VBoxContainer/_4_Operations/Control/HBoxContainer_up/questions_intergers/addition_entiers", 
"VBoxContainer/_4_Operations/Control/HBoxContainer_up/questions_intergers/soustraction_entiers", 
"VBoxContainer/_4_Operations/Control/HBoxContainer_up/questions_intergers/multiplication_entiers",
 "VBoxContainer/_4_Operations/Control/HBoxContainer_up/questions_intergers/division_entiers", 
"VBoxContainer/_4_Operations/Control/HBoxContainer_up/questions_floats/addition_decimaux", 
"VBoxContainer/_4_Operations/Control/HBoxContainer_up/questions_floats/soustraction_decimaux",
"VBoxContainer/_4_Operations/Control/HBoxContainer_up/questions_floats/multiplication_decimaux",
"VBoxContainer/_4_Operations/Control/HBoxContainer_up/questions_floats/division_decimaux", 
"VBoxContainer/_4_Operations/Control/HBoxContainer_down/questions_relatives/addition_relatifs", 
"VBoxContainer/_4_Operations/Control/HBoxContainer_down/questions_relatives/soustraction_relatifs",
 "VBoxContainer/_4_Operations/Control/HBoxContainer_down/questions_relatives/multiplication_relatifs",
"VBoxContainer/_4_Operations/Control/HBoxContainer_down/questions_relatives/division_relatifs",
 "VBoxContainer/_4_Operations/Control/HBoxContainer_down/questions_priorities/priorites_simple",
"VBoxContainer/_4_Operations/Control/HBoxContainer_down/questions_priorities/priorites_parentheses",
"VBoxContainer/Literal_calculation/Control/HBoxContainer_up/Use/calcul_valeur",
"VBoxContainer/Literal_calculation/Control/HBoxContainer_up/Use/tester_egalite_simple",
"VBoxContainer/Literal_calculation/Control/HBoxContainer_up/Use/tester_egalite_general",
"VBoxContainer/Literal_calculation/Control/HBoxContainer_up/Reduce/reduire_simple",
"VBoxContainer/Literal_calculation/Control/HBoxContainer_up/Reduce/reduire_parentheses",
"VBoxContainer/Literal_calculation/Control/HBoxContainer_down/Distribute/developpement_simple",
"VBoxContainer/Literal_calculation/Control/HBoxContainer_down/Distribute/developpement_double",
"VBoxContainer/Literal_calculation/Control/HBoxContainer_down/Distribute/factorisation_simple",
"VBoxContainer/Literal_calculation/Control/HBoxContainer_down/Distribute/factorisation_id_rem",
"VBoxContainer/Fraction/Control/HBoxContainer_up/fraction_additions/addition_fraction_simple",
"VBoxContainer/Fraction/Control/HBoxContainer_up/fraction_additions/addition_fraction_multiple",
"VBoxContainer/Fraction/Control/HBoxContainer_up/fraction_additions/addition_fraction_general",
"VBoxContainer/Fraction/Control/HBoxContainer_up/fraction_soustractions/soustraction_fraction_simple",
"VBoxContainer/Fraction/Control/HBoxContainer_up/fraction_soustractions/soustraction_fraction_multiple",
"VBoxContainer/Fraction/Control/HBoxContainer_up/fraction_soustractions/soustraction_fraction_general",
"VBoxContainer/Fraction/Control/HBoxContainer_down/fraction_multiplication_division/multiplication_fraction",
"VBoxContainer/Fraction/Control/HBoxContainer_down/fraction_multiplication_division/division_fraction",
"VBoxContainer/Arithmetic/Control/HBoxContainer/arithmetic/decomposition",
"VBoxContainer/Arithmetic/Control/HBoxContainer/arithmetic/fraction_irreductible",
"VBoxContainer/Percentage/Control/HBoxContainer/Percentage/appliquer_pourcentage",
"VBoxContainer/Percentage/Control/HBoxContainer/Percentage/trouver_pourcentage_simple",
"VBoxContainer/Percentage/Control/HBoxContainer/Percentage/trouver_pourcentage"]

var lessons_list : Array = []
var lessons_selected : Array = []
var itemlist = false

func _on_ItemList_item_selected(index):
	$ItemList.remove_item(index)
	lessons_selected.remove(index)
	itemlist = true

func _input(event):
	if (event is InputEventMouseButton && event.pressed):
		yield(get_tree().create_timer(.2), "timeout")
		if itemlist == false:
			lessons_selected = []
			check_click()
		else:
			check_list()

func check_click():
		lessons_list = []
		for i in lessons_path:
			if get_node(i).pressed:
				lessons_list += [i]
		itemlist(lessons_list)

func itemlist(_lessons : Array) -> void:
	if $ItemList.get_item_count() > 0:
		$ItemList.clear()
	for i in _lessons:
		var txt = i.split("/")
		$ItemList.add_item(txt[5])
		lessons_selected += [txt[5]]


func check_list():
	for i in lessons_path:
		var split = i.split("/")
		var name = split[5]
		if lessons_selected.has(name):
			get_node(i).pressed = true
		else:
			get_node(i).pressed = false
	itemlist = false

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
	$Control_Option/Option_unused_scenes.add_item("fight_2")


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

func before_change_scene() -> void:
	var exercices : Array = []
	var _constants : Array = []
	for i in lessons_selected:
		for j in FileBankUtils.loaded_questions:
			if j["text"] == i:
				exercices.append(j)
#				if constants[i]:
				_constants.append(constants[i])
	Scene_transition_data.set_data("questions", exercices, "constants", _constants)
	load_stats()

func _on_Option_map_item_selected(id):
	before_change_scene()
	match id:
		1:
			Fade.change_scene(FileBankUtils.load_right_scene())
#			Fade.change_scene(FileBankUtils.loaded_scenes["playing_map"][0]["map_tuto"])
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
	before_change_scene()
	match id:
		1:
			Fade.change_scene(FileBankUtils.loaded_scenes["map_fight_1"])

func _on_Option_featured_scenes_item_selected(id):
	before_change_scene()
	match id:
		1:
			Fade.change_scene(FileBankUtils.loaded_scenes["rewards"])
		2:
			Fade.change_scene(FileBankUtils.loaded_scenes["shop"])
		3:
			Fade.change_scene(FileBankUtils.loaded_scenes["death"])

func _on_Option_unused_scenes_item_selected(id):
	before_change_scene()
	match id:
		1:
			Fade.change_scene(FileBankUtils.loaded_scenes["create_hero"])
		2:
			Fade.change_scene(FileBankUtils.loaded_scenes["map_fight_2"])
	
func _on_Conversion_pressed():
	show_notion(notions_show, "VBoxContainer/Conversion/Control")
	press_notion(notions_press, "VBoxContainer/Conversion")

func _on_Percentage_pressed():
	show_notion(notions_show, "VBoxContainer/Percentage/Control")
	press_notion(notions_press, "VBoxContainer/Percentage")


func _on_Arithmetic_pressed():
	show_notion(notions_show, "VBoxContainer/Arithmetic/Control")
	press_notion(notions_press, "VBoxContainer/Arithmetic")


func _on_Fraction_pressed():
	show_notion(notions_show, "VBoxContainer/Fraction/Control")
	press_notion(notions_press, "VBoxContainer/Fraction")


func _on_Literal_calculation_pressed():
	show_notion(notions_show, "VBoxContainer/Literal_calculation/Control")
	press_notion(notions_press, "VBoxContainer/Literal_calculation")


func _on_4_Operations_pressed():
	show_notion(notions_show, "VBoxContainer/_4_Operations/Control")
	press_notion(notions_press, "VBoxContainer/_4_Operations")

func _on_Fonction_pressed():
	pass


func _on_Power_pressed():
	pass


func _on_TouchScreenButton_pressed():
	if len(lessons_selected) == 0:

		$VBoxContainer.hide()
		$PopupDialog.show()
	else:
		before_change_scene()
#		Fade.change_scene(FileBankUtils.loaded_scenes["rewards"])
	#	Fade.change_scene(FileBankUtils.loaded_scenes["playing_map"][0]["map_tuto"])
		Fade.change_scene(FileBankUtils.load_right_scene())


func _on_TouchScreenButton2_pressed():
	before_change_scene()
	Fade.change_scene(FileBankUtils.loaded_scenes["playing_map"][1]["map_fire"])


func _on_TouchScreenButton3_pressed():
	before_change_scene()
	Fade.change_scene(FileBankUtils.loaded_scenes["map_water"])

func _on_TouchScreenButton4_pressed():
#	Fade.change_scene(FileBankUtils.loaded_scenes["fonctions"])
	get_tree().change_scene("res://Src/Outgame/Fonctions.tscn")

func _on_TextureButton_pressed():
	$PopupDialog.hide()
	$VBoxContainer.show()

func _process(delta):
	if FileBankUtils.popup:
		var popup : Popup = Popup.new()
		add_child(popup)
		var text  : Label = Label.new()
		text.text = "Fractions images are not up to date ! Please generate them"
		popup.add_child(text)
		popup.show()
		popup.set_position($TileMap/pseudo.get_position())
		FileBankUtils.popup = false



