extends Node

enum EntryType { School, Teacher, Class, Student}

var database : Array = []
var next_id : Array = []

const invalid_id : int = -1
const invalid_value : String = "null"
const first_id : int = 0

class IOHandler:
	const __file_name : String = "res://Assets/player_id_database.json"

	static func load(var db) -> bool:
		if !File.new().file_exists(__file_name):
			return false

		var data = FileUtils.load_json(__file_name)
		if data == null || !(data is Dictionary):
			return false

		var dict = data as Dictionary
		for k in dict.keys():
			if !EntryType.has(k):
				continue
			var loaded_values = dict[k]
			if !(loaded_values is Dictionary):
				continue

			# Json keys are always strings so we have to parse them into ids
			var values = db[EntryType[k]]
			for id_str in loaded_values.keys():
				var id = int(id_str)
				if values.has(id):
					return false
				values[id] = loaded_values[id_str]

		return true

	static func save(var db) -> bool:
		var jsonData : Dictionary = {}
		for typeStr in EntryType.keys():
			jsonData[typeStr] = db[EntryType[typeStr]]
		return FileUtils.save_json(jsonData, __file_name)

func _ready():
	__init_from_void()
	if IOHandler.load(database):
		__compute_next_ids()

func _exit_tree():
	commit()

func commit() -> bool:
	return IOHandler.save(database)

func insert_school(var name : String) -> int:
	return insert_value(EntryType.School, name)

func insert_teacher(var name : String) -> int:
	return insert_value(EntryType.Teacher, name)

func insert_class(var name : String) -> int:
	return insert_value(EntryType.Class, name)

func insert_student(var name : String) -> int:
	return insert_value(EntryType.Student, name)

func remove_school_name(var id : int) -> bool:
	return remove_value(EntryType.School, id)

func remove_teacher_name(var id : int) -> bool:
	return remove_value(EntryType.Teacher, id)

func remove_class_name(var id : int) -> bool:
	return remove_value(EntryType.Class, id)

func remove_student_name(var id : int) -> bool:
	return remove_value(EntryType.Student, id)

func set_school_name(var id : int, var name : String) -> bool:
	return set_value(EntryType.School, id, name)

func set_teacher_name(var id : int, var name : String) -> bool:
	return set_value(EntryType.Teacher, id, name)

func set_class_name(var id : int, var name : String) -> bool:
	return set_value(EntryType.Class, id, name)

func set_student_name(var id : int, var name : String) -> bool:
	return set_value(EntryType.Student, id, name)

func get_school_name(var id : int) -> String:
	return get_value(EntryType.School, id)

func get_teacher_name(var id : int) -> String:
	return get_value(EntryType.Teacher, id)

func get_class_name(var id : int) -> String:
	return get_value(EntryType.Class, id)

func get_student_name(var id : int) -> String:
	return get_value(EntryType.Student, id)

func get_all_schools() -> Dictionary:
	return get_all_values(EntryType.School)

func get_all_teachers() -> Dictionary:
	return get_all_values(EntryType.Teacher)

func get_all_classes() -> Dictionary:
	return get_all_values(EntryType.Class)

func get_all_student() -> Dictionary:
	return get_all_values(EntryType.Student)

func insert_value(var type : int, var value: String) -> int:
	var values : Dictionary = __get_all_values_read_write(type)
	var id : int = __get_next_id(type)
	if id == invalid_id || values.has(id):
		return invalid_id
	values[id] = value
	next_id[type] = id + 1
	print("values : ", values)
	return id

func remove_value(var type : int, var id : int) -> bool:
	var values : Dictionary = __get_all_values_read_write(type)
	if !values.has(id):
		return false
	return values.erase(id)

func reset() -> void:
	database.clear()
	next_id.clear()
	__init_from_void()

func set_value(var type : int, var id : int, var value : String) -> bool:
	var values : Dictionary = __get_all_values_read_write(type)
	if !values.has(id):
		return false
	values[id] = value
	return true

func get_value(var type : int, var id : int) -> String:
	var values : Dictionary = __get_all_values_read_write(type)
	if !values.has(id):
		return invalid_value
	return values[id]

func __get_all_values_read_write(var type : int) -> Dictionary:
	if !__is_type_valid(type):
		return {}
	return database[type]

func get_all_values(var type : int) -> Dictionary:
	return __get_all_values_read_write(type).duplicate()

func __is_type_valid(var type : int) -> bool:
	return type >= 0 && type < EntryType.size()

func __get_next_id(var type : int) -> int:
	if !__is_type_valid(type):
		return invalid_id
	return next_id[type]

func __compute_next_ids() -> void:
	for type in EntryType.values():
		var max_id = invalid_id
		for id in database[type].keys():
			if max_id == invalid_id || id > max_id:
				max_id = id
		next_id[type] = max_id + 1 if max_id != invalid_id else first_id

func __init_from_void():
	for type in EntryType.values():
		database.append({})
		next_id.append(first_id)
