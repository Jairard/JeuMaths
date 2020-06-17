extends Node

var health 			: int = 0
var health_max		: int = 0
var damage 			: int = 0
var treasure 		: int = 0
var good_answer 	: int = 0
var wrong_answer 	: int = 0
var victories	 	: int = 0
var defeats 		: int = 0
var scene_counter	: int = 0
var classroom		: int = 0
var pseudo			: String = ""
var popup			= false
var portal			= false

var loaded_scenes = load_json("res://Assets/Scenes.json")
var stats_File_Name : String = "res://Assets/Stats_Characters/Hero_Stats.json"
var loaded_heroes_stats = load_json(stats_File_Name)
var loaded_questions = load_json("res://Assets/Questions/questions.json")
var loaded_fractions = load_fractions("res://Tools/Fractions/")

func load_fractions(path : String) -> Dictionary:
	var pictures : Dictionary = {}
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			break
		elif file_name.ends_with(".png"):
			pictures[file_name] = load(path + "/" + file_name)
	dir.list_dir_end()
	return pictures

func _ready():
	check_fractions_gen()

func get_error_msg(error) -> String:
	match error:
		OK:
			return "OK"
		FAILED:
			return "Generic error"
		ERR_UNAVAILABLE:
			return "Unavailable error"
		ERR_UNCONFIGURED:
			return "Unconfigured error"
		ERR_UNAUTHORIZED:
			return "Unauthorized error"
		ERR_PARAMETER_RANGE_ERROR:
			return "Parameter range error"
		ERR_OUT_OF_MEMORY:
			return "Out of memory (OOM) error"
		ERR_FILE_NOT_FOUND:
			return "File: Not found error"
		ERR_FILE_BAD_DRIVE:
			return "File: Bad drive error"
		ERR_FILE_BAD_PATH:
			return "File: Bad path error"
		ERR_FILE_NO_PERMISSION:
			return "File: No permission error"
		ERR_FILE_ALREADY_IN_USE:
			return "File: Already in use error"
		ERR_FILE_CANT_OPEN:
			return "File: Can't open error"
		ERR_FILE_CANT_WRITE:
			return "File: Can't write error"
		ERR_FILE_CANT_READ:
			return "File: Can't read error"
		ERR_FILE_UNRECOGNIZED:
			return "File: Unrecognized error"
		ERR_FILE_CORRUPT:
			return "File: Corrupt error"
		ERR_FILE_MISSING_DEPENDENCIES:
			return "File: Missing dependencies error"
		ERR_FILE_EOF:
			return "File: End of file (EOF) error"
		ERR_CANT_OPEN:
			return "Can't open error"
		ERR_CANT_CREATE:
			return "Can't create error"
		ERR_QUERY_FAILED:
			return "Query failed error"
		ERR_ALREADY_IN_USE:
			return "Already in use error"
		ERR_LOCKED:
			return "Locked error"
		ERR_TIMEOUT:
			return "Timeout error"
		ERR_CANT_CONNECT:
			return "Can't connect error"
		ERR_CANT_RESOLVE:
			return "Can't resolve error"
		ERR_CONNECTION_ERROR:
			return "Connection error"
		ERR_CANT_ACQUIRE_RESOURCE:
			return "Can't acquire resource error"
		ERR_CANT_FORK:
			return "Can't fork process error"
		ERR_INVALID_DATA:
			return "Invalid data error"
		ERR_INVALID_PARAMETER:
			return "Invalid parameter error"
		ERR_ALREADY_EXISTS:
			return "Already exists error"
		ERR_DOES_NOT_EXIST:
			return "Does not exist error"
		ERR_DATABASE_CANT_READ:
			return "Database: Read error"
		ERR_DATABASE_CANT_WRITE:
			return "Database: Write error"
		ERR_COMPILATION_FAILED:
			return "Compilation failed error"
		ERR_METHOD_NOT_FOUND:
			return "Method not found error"
		ERR_LINK_FAILED:
			return "Linking failed error"
		ERR_SCRIPT_FAILED:
			return "Script failed error"
		ERR_CYCLIC_LINK:
			return "Cycling link (import cycle) error"
		ERR_INVALID_DECLARATION:
			return "Invalid declaration error"
		ERR_DUPLICATE_SYMBOL:
			return "Duplicate symbol error"
		ERR_PARSE_ERROR:
			return "Parse error"
		ERR_BUSY:
			return "Busy error"
		ERR_SKIP:
			return "Skip error"
		ERR_HELP:
			return "Help error"
		ERR_BUG:
			return "Bug error"
		ERR_PRINTER_ON_FIRE:
			return "Printer on fire error"
	return "Unknown error"

func safe_open_file(path : String, flags : int, function_name : String) -> File:
	var file = File.new()
	var res = file.open(path, flags)
	if (res == OK):
		return file
	push_error("An error occurend while opening '" + path + "' in " + function_name + ": " + get_error_msg(res))
	return null

func check_fractions_gen() -> void:
	if (get_fractions_gen_hash() != get_fractions_hash()):
		popup = true
		push_error("Fractions images are not up to date ! Please generate them")

func get_fractions_gen_hash() -> String:
	var file = safe_open_file("res://Tools/Fractions/hash.md5", File.READ, "get_fractions_gen_hash")
	return file.get_as_text() if file != null else ""

func get_fractions_hash() -> String:
	var file = safe_open_file("res://Tools/fraction.txt", File.READ, "get_fractions_hash")
	return file.get_as_text().md5_text() if file != null else ""

func load_json(path : String):
	var file = safe_open_file(path, File.READ, "load_json")
	if file == null:
		return null
	var text = file.get_as_text()
	var content = parse_json(text)
	file.close()
	return content

func save_json(dict,path : String) -> void:
	var file = safe_open_file(path, File.WRITE, "save_json")
	if file == null:
		return
	var streuh = to_json(dict)
	file.store_string(streuh)
	file.close()

func init_stats(stats : Dictionary, _pseudo : String) -> void:
	health 			= stats["health"]
	damage 			= stats["damage"]
	treasure		= stats["treasure"]
	good_answer 	= stats["good_answer"]
	wrong_answer 	= stats["wrong_answer"]
	victories	 	= stats["victories"]
	defeats			= stats["defeats"]
	health_max		= stats["health_max"]
	pseudo			= _pseudo
	scene_counter	= stats["scene_counter"]
	
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		var stats : Dictionary = {
									"damage":damage, "health":health,
									"treasure":treasure,"good_answer":good_answer,"wrong_answer":wrong_answer,
									"victories":victories, "defeats":defeats,
									"health_max":health_max, "scene_counter":scene_counter	  
								}
		if loaded_heroes_stats == null:
			loaded_heroes_stats = {}
		loaded_heroes_stats[pseudo] = stats
		save_json(loaded_heroes_stats, stats_File_Name)

func load_right_scene() -> String:
#	if FileBankUtils.scene_counter == 0:
#		return FileBankUtils.loaded_scenes["playing_map"][0]["map_tuto"]
	match FileBankUtils.scene_counter % 5:
		0:
			return FileBankUtils.loaded_scenes["playing_map"][0]["map_tuto"]
		1:
			return FileBankUtils.loaded_scenes["playing_map"][1]["map_fire"]
		2:
			return FileBankUtils.loaded_scenes["map_water"]
		3:
			return FileBankUtils.loaded_scenes["playing_map"][2]["map_fire_0"]
		4:
			return FileBankUtils.loaded_scenes["map_water_0"]
		5:
			return FileBankUtils.loaded_scenes["upside_down"]
	return ""

