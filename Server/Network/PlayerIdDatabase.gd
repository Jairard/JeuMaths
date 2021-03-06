extends Node

enum EntryType { School, Teacher, Class, Student}
enum RelationType {SchoolClass, ClassStudent }

var RelationTable : Array = []
var database : Array = []
var next_id : Array = []

const invalid_id : int = -1
const invalid_value : String = "null"
const first_id : int = 0

class IOHandler:
	const __file_name : String = "res://Assets/player_id_database.json"

	static func load(var db, var rt) -> bool:
		if !File.new().file_exists(__file_name):
			return false

		var data = FileUtils.load_json(__file_name)
		if data == null || !(data is Dictionary):
			return false

		var dict = data as Dictionary
		if !dict.has("Entities") or !dict.has("RelationData"):
			return false

		var EntitiesData : Dictionary = dict["Entities"]
		var RelationData : Dictionary = dict["RelationData"]
		return LoadDataFromJson(RelationData, RelationType, rt) and LoadDataFromJson(EntitiesData, EntryType, db)

	static func save(var db, var rt) -> bool:
		var EntititesData : Dictionary = {}
		for typeStr in EntryType.keys():
			EntititesData[typeStr] = db[EntryType[typeStr]]
		var RelationData : Dictionary = {}
		for typeStr in RelationType.keys():
			RelationData[typeStr] = rt[RelationType[typeStr]]
		var JsonData : Dictionary = {"Entities" : EntititesData, "RelationData" : RelationData}
		return FileUtils.save_json(JsonData, __file_name)

	static func LoadDataFromJson(var JsonData, var ExpectedKeys, var OutData) -> bool:
		for k in JsonData.keys():
			if !ExpectedKeys.has(k):
				continue
			var loaded_values = JsonData[k]
			if !(loaded_values is Dictionary):
				continue

			# Json keys are always strings so we have to parse them into ids
			var values = OutData[ExpectedKeys[k]]
			for id_str in loaded_values.keys():
				var id = int(id_str)
				if values.has(id):
					return false
				values[id] = loaded_values[id_str]
		return true

func _ready():
	__init_from_void()
	if IOHandler.load(database, RelationTable):
		__compute_next_ids()

func _exit_tree():
	commit()

func commit() -> bool:
	return IOHandler.save(database, RelationTable)

func insert_school_class_relation(var classid : int, var schoolid : int) -> void:
	insert_relation(RelationType.SchoolClass, classid, schoolid)

func insert_class_student_relation(var Studentid : int, var classid : int) -> void:
	insert_relation(RelationType.ClassStudent, Studentid, classid)

func insert_relation(var type : int, var to_id : int, var from_id : int) -> void:
	var table : Dictionary = RelationTable[type]
	if !table.has(from_id):
		table[from_id] = []
	#TODO : tester si class id existe déjà avec log
	table[from_id].append(to_id)
	print("table : ", table)

func get_school_of_class(var classid : int) -> int:
	return get_related_unique_element(RelationType.SchoolClass , classid)

func get_class_of_student(var studentid : int) -> int:
	return get_related_unique_element(RelationType.ClassStudent , studentid)

func get_related_unique_element( var type : int, var to_id : int) -> int:
	var table : Dictionary = RelationTable[type]	#{1 : [1.2.3]}
	for from_id in table.keys():
		if to_id in table[from_id]:
			return from_id
	return invalid_id

func get_related_elements(var type: int, var from_id : int) -> Array:
	var table : Dictionary = RelationTable[type]
	if table.has(from_id):
		return table[from_id]
	return []

func get_classes_of_school(var schoolid : int) -> Array:
	return get_related_elements(RelationType.SchoolClass , schoolid)

func get_students_of_class(var classid : int) -> Array:
	return get_related_elements(RelationType.ClassStudent , classid)

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
	for type in RelationType.values():
		RelationTable.append({})
