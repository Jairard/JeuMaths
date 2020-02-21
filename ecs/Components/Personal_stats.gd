extends Component

class_name PersonnalStatsComponent

var good_answer : int = 0
var wrong_answer : int = 0
var victories : int = 0
var defeats : int = 0

func init(_good_answer : int, _wrong_answer : int, _victories : int, _defeats : int) -> void :
	good_answer = _good_answer
	wrong_answer = _wrong_answer
	victories = _victories
	defeats = _defeats
		
func get_good_answer() -> int:
	return good_answer

func set_good_answer(value : int) -> void:
	good_answer = value

func get_wrong_answer() -> int:
	return wrong_answer

func set_wrong_answer(value : int) -> void:
	wrong_answer = value

func get_victories() -> int:
	return victories

func set_victories(value : int) -> void:
	victories = value

func get_defeats() -> int:
	return defeats

func set_defeats(value : int) -> void:
	defeats = value
