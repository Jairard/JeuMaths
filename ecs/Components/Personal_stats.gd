extends Component

class_name PersonnalStatsComponent

var good_anser : int = 0
var wrong_answer : int = 0
var victories : int = 0
var dfefeats : int = 0

func get_good_answer() -> int:
	return good_anser

func set_good_answer(value : int) -> void:
	good_anser = value

func get_wrong_answer() -> int:
	return wrong_answer

func set_wrong_answer(value : int) -> void:
	wrong_answer = value

func get_victories() -> int:
	return victories

func set_victories(value : int) -> void:
	victories = value

func get_defeats() -> int:
	return dfefeats

func set_defeats(value : int) -> void:
	dfefeats = value
