extends Component

class_name ScoreglobalcounterComponent

var good_answer 	: int = 0
var wrong_answer 	: int = 0
var victories	 	: int = 0
var defeats			: int = 0

func init_score(_good_answer : int, _wrong_answer : int,
		  _victories : int):
	if (!was_ghost()):
		good_answer = _good_answer
		wrong_answer = _wrong_answer
		victories = _victories
	
func init_stats(_good_answer : int, _wrong_answer : int, _victories : int, _defeats : int) -> void :
	good_answer = _good_answer
	wrong_answer = _wrong_answer
	victories = _victories
	defeats = _defeats
	
func compute_score() -> float:
	return ((get_victories()+1) * (float(get_good_answer()+1) / (get_wrong_answer()+1)) * 1000)

func get_good_answer() -> int:
	return good_answer

func set_good_answer(_good_answer) -> void:
		good_answer = _good_answer

func get_wrong_answer() -> int:
	return wrong_answer

func set_wrong_answer(_wrong_answer) -> void:
		wrong_answer = _wrong_answer

func get_victories() -> int:
	return victories

func set_victories(_victories) -> void:
		victories = _victories
		
func get_defeats() -> int:
	return defeats

func set_defeats(value : int) -> void:
	defeats = value
	
	
