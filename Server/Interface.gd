extends Node2D

var selectionned_stat : String = ""
var previous_stats : String = ""
var stats : Array = ["Statistics/Stats/ControlStats", "Statistics/Stats/ControlFirstDetailStats", "Statistics/Stats/ControlSecondDetailStats"]
var statsFirstDetail : Array = ["Statistics/Stats/ControlFirstDetailStats/FirstDetailStats/CalculLitteral",
								"Statistics/Stats/ControlFirstDetailStats/FirstDetailStats/4Operations",
								"Statistics/Stats/ControlFirstDetailStats/FirstDetailStats/Fractions",
								"Statistics/Stats/ControlFirstDetailStats/FirstDetailStats/Arithmetic",
								"Statistics/Stats/ControlFirstDetailStats/FirstDetailStats/Percentage"]
var statsSecondDetail : Array = ["Statistics/Stats/ControlSecondDetailStats/SecondDetailStats4Operations",
								"Statistics/Stats/ControlSecondDetailStats/SecondDetailStatsLitteral",
								"Statistics/Stats/ControlSecondDetailStats/SecondDetailStatsFraction"]
var statsSecondDetail4Operations : Array = ["Statistics/Stats/ControlSecondDetailStats/SecondDetailStats4Operations/Entire",
								"Statistics/Stats/ControlSecondDetailStats/SecondDetailStats4Operations/Decimal",
								"Statistics/Stats/ControlSecondDetailStats/SecondDetailStats4Operations/Relative",
								"Statistics/Stats/ControlSecondDetailStats/SecondDetailStats4Operations/Priorities"]
var statsSecondDetailLitteral : Array = ["Statistics/Stats/ControlSecondDetailStats/SecondDetailStatsLitteral/TestValue",
										"Statistics/Stats/ControlSecondDetailStats/SecondDetailStatsLitteral/Reduce",
										"Statistics/Stats/ControlSecondDetailStats/SecondDetailStatsLitteral/Distribute"]
var statsSecondDetailFraction : Array = ["Statistics/Stats/ControlSecondDetailStats/SecondDetailStatsFraction/Addition",
										"Statistics/Stats/ControlSecondDetailStats/SecondDetailStatsFraction/Soustraction",
										"Statistics/Stats/ControlSecondDetailStats/SecondDetailStatsFraction/Multiplication"]
var bdd_school 		: Dictionary = {}
var bdd_class 		: Dictionary = {}
var bdd_student		: Dictionary = {}

var ClassOfSchool : Array = []

var selectionned_text :String = ""
var id : int = 0

onready var tests = preload("res://Tests/MessageListenerSandbox.tscn").instance()

func _ready():
#	PlayerIdDatabase.reset()
	show_stats(stats, "Stats/ControlStats")
	add_child(tests)
	SchoolNameList(PlayerIdDatabase.get_all_schools())
	ClassNameList(PlayerIdDatabase.get_all_classes())
	StudentNameList(PlayerIdDatabase.get_all_student())
	bdd_school = PlayerIdDatabase.get_all_schools()
	bdd_class = PlayerIdDatabase.get_all_classes()
	bdd_student = PlayerIdDatabase.get_all_student()
	$Statistics.hide()
	$Management.show()

func show_stats(stats : Array , node1 : String, node2 : String = "", node3 : String = "",
				node4 : String = "", node5 : String = "", node6 : String = "") -> void: 
	for stat in stats:
		if stat == node1:
			print(stat)
			get_node(stat).show()
			print(stat)
		elif stat == node2:
			get_node(stat).show()
		elif stat == node3:
			get_node(node3).show()
		elif stat == node4:
			get_node(node4).show()
		elif stat == node5:
			get_node(node5).show()
		elif stat == node6:
			get_node(node6).show()
		else:
			get_node(stat).hide()

func _on_Return_pressed():
	match (previous_stats):
		"Stats":
			show_stats(stats, "Statistics/Stats/ControlStats")
			$Statistics/Return.hide()
		"FirstDetailStats":
			show_stats(stats, "Statistics/Stats/ControlFirstDetailStats")
			$Statistics/Return.show()
			previous_stats = "Statistics/Stats"


func _on_4Operations2_pressed():
	show_stats(stats, "Statistics/Stats/ControlFirstDetailStats")
	previous_stats = "Statistics/Stats"
	selectionned_stat = "Statistics/Stats/ControlFirstDetailStats/FirstDetailStats/4Operations"
	show_stats(statsFirstDetail, selectionned_stat)
	$Statistics/Return.show()


func _on_CalculLitteral2_pressed():
	show_stats(stats, "Statistics/Stats/ControlFirstDetailStats")
	previous_stats = "Statistics/Stats"
	selectionned_stat = "Statistics/Stats/ControlFirstDetailStats/FirstDetailStats/CalculLitteral"
	show_stats(statsFirstDetail, selectionned_stat)
	$Statistics/Return.show()


func _on_Fraction_pressed():
	show_stats(stats, "Statistics/Stats/ControlFirstDetailStats")
	previous_stats = "Statistics/Stats"
	selectionned_stat = "Statistics/Stats/ControlFirstDetailStats/FirstDetailStats/Fractions"
	show_stats(statsFirstDetail, selectionned_stat)
	$Statistics/Return.show()


func _on_arithmetic_pressed():
	show_stats(stats, "Statistics/Stats/ControlFirstDetailStats")
	previous_stats = "Statistics/Stats"
	selectionned_stat = "Statistics/Stats/ControlFirstDetailStats/FirstDetailStats/Arithmetic"
	show_stats(statsFirstDetail, selectionned_stat)
	$Statistics/Return.show()

func _on_percentage_pressed():
	show_stats(stats, "Statistics/Stats/ControlFirstDetailStats")
	previous_stats = "Statistics/Stats"
	selectionned_stat = "Statistics/Stats/ControlFirstDetailStats/FirstDetailStats/Percentage"
	show_stats(statsFirstDetail, selectionned_stat)
	$Statistics/Return.show()


func _on_Entire_pressed():
	show_stats(stats, "Statistics/Stats/ControlSecondDetailStats")
	show_stats(statsSecondDetail, "Statistics/Stats/ControlSecondDetailStats/SecondDetailStats4Operations")
	previous_stats = "Statistics/FirstDetailStats"
	selectionned_stat = "Statistics/Stats/ControlSecondDetailStats/SecondDetailStats4Operations/Entire"
	show_stats(statsSecondDetail4Operations, selectionned_stat)
	$Statistics/Return.show()


func _on_Decimal_pressed():
	show_stats(stats, "Statistics/Stats/ControlSecondDetailStats")
	show_stats(statsSecondDetail, "Statistics/Stats/ControlSecondDetailStats/SecondDetailStats4Operations")
	previous_stats = "Statistics/FirstDetailStats"
	selectionned_stat = "Statistics/Stats/ControlSecondDetailStats/SecondDetailStats4Operations/Decimal"
	show_stats(statsSecondDetail4Operations, selectionned_stat)
	$Statistics/Return.show()


func _on_Relative_pressed():
	show_stats(stats, "Statistics/Stats/ControlSecondDetailStats")
	show_stats(statsSecondDetail, "Statistics/Stats/ControlSecondDetailStats/SecondDetailStats4Operations")
	previous_stats = "Statistics/FirstDetailStats"
	selectionned_stat = "Statistics/Stats/ControlSecondDetailStats/SecondDetailStats4Operations/Relative"
	show_stats(statsSecondDetail4Operations, selectionned_stat)
	$Statistics/Return.show()


func _on_Priorities_pressed():
	show_stats(stats, "Statistics/Stats/ControlSecondDetailStats")
	show_stats(statsSecondDetail, "Statistics/Stats/ControlSecondDetailStats/SecondDetailStats4Operations")
	previous_stats = "Statistics/FirstDetailStats"
	selectionned_stat = "Statistics/Stats/ControlSecondDetailStats/SecondDetailStats4Operations/Priorities"
	show_stats(statsSecondDetail4Operations, selectionned_stat)
	$Statistics/Return.show()




func _on_TestValue_pressed():
	show_stats(stats, "Statistics/Stats/ControlSecondDetailStats")
	show_stats(statsSecondDetail, "Statistics/Stats/ControlSecondDetailStats/SecondDetailStatsLitteral")
	previous_stats = "Statistics/FirstDetailStats"
	selectionned_stat = "Statistics/Stats/ControlSecondDetailStats/SecondDetailStatsLitteral/TestValue"
	show_stats(statsSecondDetailLitteral, selectionned_stat)
	$Return.show()

func _on_Reduce_pressed():
	show_stats(stats, "Statistics/Stats/ControlSecondDetailStats")
	show_stats(statsSecondDetail, "Statistics/Stats/ControlSecondDetailStats/SecondDetailStatsLitteral")
	previous_stats = "Statistics/FirstDetailStats"
	selectionned_stat = "Statistics/Stats/ControlSecondDetailStats/SecondDetailStatsLitteral/Reduce"
	show_stats(statsSecondDetailLitteral, selectionned_stat)
	$Statistics/Return.show()


func _on_Distribute_pressed():
	show_stats(stats, "Statistics/Stats/ControlSecondDetailStats")
	show_stats(statsSecondDetail, "Statistics/Stats/ControlSecondDetailStats/SecondDetailStatsLitteral")
	previous_stats = "Statistics/FirstDetailStats"
	selectionned_stat = "Statistics/Stats/ControlSecondDetailStats/SecondDetailStatsLitteral/Distribute"
	show_stats(statsSecondDetailLitteral, selectionned_stat)
	$Statistics/Return.show()


func _on_Addition_pressed():
	show_stats(stats, "Statistics/Stats/ControlSecondDetailStats")
	show_stats(statsSecondDetail, "Statistics/Stats/ControlSecondDetailStats/SecondDetailStatsFraction")
	previous_stats = "Statistics/FirstDetailStats"
	selectionned_stat = "Statistics/Stats/ControlSecondDetailStats/SecondDetailStatsFraction/Addition"
	show_stats(statsSecondDetailFraction, selectionned_stat)
	$Statistics/Return.show()


func _on_Soustraction_pressed():
	show_stats(stats, "Statistics/Stats/ControlSecondDetailStats")
	show_stats(statsSecondDetail, "Statistics/Stats/ControlSecondDetailStats/SecondDetailStatsFraction")
	previous_stats = "Statistics/FirstDetailStats"
	selectionned_stat = "Statistics/Stats/ControlSecondDetailStats/SecondDetailStatsFraction/Soustraction"
	show_stats(statsSecondDetailFraction, selectionned_stat)
	$Statistics/Return.show()


func _on_Multiplication_pressed():
	show_stats(stats, "Statistics/Stats/ControlSecondDetailStats")
	show_stats(statsSecondDetail, "Statistics/Stats/ControlSecondDetailStats/SecondDetailStatsFraction")
	previous_stats = "Statistics/FirstDetailStats"
	selectionned_stat = "Statistics/Stats/ControlSecondDetailStats/SecondDetailStatsFraction/Multiplication"
	show_stats(statsSecondDetailFraction, selectionned_stat)
	$Statistics/Return.show()


func _on_SwapStats_pressed():
	$Statistics.show()
	$Management.hide()
	show_stats(stats, "Statistics/Stats/ControlStats")


func _on_SwapCreator_pressed():
	$Statistics.hide()
	$Management.show()


func _on_AddSchool_pressed():
	$Management/SchoolText.show()


func _on_CheckSchool_pressed():
	var SchoolName : String = $Management/SchoolText.get_text()
	var SchoolList : Dictionary = PlayerIdDatabase.get_all_schools()
	var SchoolListValues : Array = SchoolList.values()
	if !SchoolListValues.has(SchoolName):
		id = PlayerIdDatabase.insert_school(SchoolName)
		bdd_school[id] = SchoolName
		SchoolList = PlayerIdDatabase.get_all_schools()
		SchoolNameList(SchoolList)
	$Management/SchoolText.clear()
	$Management/SchoolText.hide()
	$Management/CheckSchool.hide()


func SchoolNameList(NewSchoolList : Dictionary) -> void:
	$Management/ListSchool.clear()
	for School in NewSchoolList:
		$Management/ListSchool.add_separator()
		$Management/ListSchool.add_item(str(NewSchoolList[School]))


func _on_ListSchool_item_selected(id):
	selectionned_text = $Management/ListSchool.get_item_text(id)
	$Management/DeleteSchool.show()
	$Management/Class.show()
	$Management/AddClass.show()
	$Management/ListClass.show()
	print("RELATION table : ", PlayerIdDatabase.RelationTable)
	ClassOfSchool = PlayerIdDatabase.get_classes_of_school(PlayerIdDatabase.EntryType.School)
	print("classes : ", ClassOfSchool)
	ClassOfSchoolList(ClassOfSchool)

func ClassOfSchoolList(ExistingClass : Array) -> void:
#	print("existing class : ", ExistingClass)
	for Class in ExistingClass:
		$Management/ListClass.add_separator()
		$Management/ListSClass.add_item(str(Class))

func _on_DeleteSchool_pressed():
	for key in bdd_school.keys():
		if bdd_school[key] == selectionned_text:
			PlayerIdDatabase.remove_school_name(key)
			bdd_school = PlayerIdDatabase.get_all_schools()
			SchoolNameList(PlayerIdDatabase.get_all_schools())
			$Management/DeleteSchool.hide()


func _on_SchoolText_text_changed(new_text):
	$Management/CheckSchool.show()



func _on_AddClass_pressed():
	$Management/ClassText.show()


func _on_ClassText_text_changed(new_text):
	$Management/CheckClass.show()

func _on_ListClass_item_selected(id):
	selectionned_text = $Management/ListClass.get_item_text(id)
	$Management/DeleteClass.show()
	$Management/AddStudent.show()
	$Management/ListStudent.show()

func _on_CheckClass_pressed():
	var ClassName : String = $Management/ClassText.get_text()
	var ClassList : Dictionary = PlayerIdDatabase.get_all_classes()
	var ClassListeValues : Array = ClassList.values()
	if !ClassListeValues.has(ClassName):
		id = PlayerIdDatabase.insert_class(ClassName)
		bdd_class[id] = ClassName
		ClassList = PlayerIdDatabase.get_all_classes()
		PlayerIdDatabase.insert_school_class_relation(PlayerIdDatabase.EntryType.Class, PlayerIdDatabase.EntryType.School)
		print("relation table : ", PlayerIdDatabase.RelationTable)
		ClassOfSchool = PlayerIdDatabase.get_classes_of_school(PlayerIdDatabase.EntryType.School)
		print("classes upload : ", ClassOfSchool)
		ClassNameList(ClassList)
	$Management/ClassText.clear()
	$Management/ClassText.hide()
	$Management/CheckClass.hide()

func ClassNameList(NewClassList : Dictionary) -> void:
	$Management/ListClass.clear()
	for Class in NewClassList:
		$Management/ListClass.add_separator()
		$Management/ListClass.add_item(str(NewClassList[Class]))


func _on_DeleteClass_pressed():
	for key in bdd_class.keys():
		if bdd_class[key] == selectionned_text:
			PlayerIdDatabase.remove_class_name(key)
			bdd_class = PlayerIdDatabase.get_all_classes()
	ClassNameList(PlayerIdDatabase.get_all_classes())
	$Management/DeleteClass.hide()


func _on_AddStudent_pressed():
	$Management/StudentText.show()


func _on_StudentText_text_changed(new_text):
	$Management/CheckStudent.show()

func _on_CheckStudent_pressed():
	var StudentName : String = $Management/StudentText.get_text()
	var StudentList : Dictionary = PlayerIdDatabase.get_all_student()
	var StudentListeValues : Array = StudentList.values()
	if !StudentListeValues.has(StudentName):
		id = PlayerIdDatabase.insert_student(StudentName)
		bdd_student[id] = StudentName
		StudentList = PlayerIdDatabase.get_all_student()
		StudentNameList(StudentList)
	$Management/StudentText.clear()
	$Management/StudentText.hide()
	$Management/CheckStudent.hide()

func StudentNameList(NewStudentList : Dictionary) -> void:
	$Management/ListStudent.clear()
	for Student in NewStudentList:
		$Management/ListStudent.add_item(str(NewStudentList[Student]))

func _on_ListStudent_item_selected(index):
	selectionned_text = $Management/ListStudent.get_item_text(id)
	print("selectionned text : ", selectionned_text)
	$Management/DeleteStudent.show()


func _on_DeleteStudent_pressed():
	for key in bdd_student.keys():
		if bdd_student[key] == selectionned_text:
			PlayerIdDatabase.remove_student_name(key)
			bdd_student = PlayerIdDatabase.get_all_student()
			print(bdd_student)
	StudentNameList(PlayerIdDatabase.get_all_student())
	$Management/DeleteStudent.hide()
