extends Component

class_name ScoreglobalcounterComponent

var good_answer 	: int = 0
var wrong_answer 	: int = 0
var boss_killed 	: int = 0

func init_score() -> float:
	return (get_boss_killed() * (float(get_good_answer()) / get_wrong_answer()) * 1000)

func get_good_answer() -> int:
	return good_answer

func set_good_answer(_good_answer) -> void:
	good_answer = _good_answer
	
func get_wrong_answer() -> int:
	return wrong_answer

func set_wrong_answer(_wrong_answer) -> void:
	wrong_answer = _wrong_answer
	
func get_boss_killed() -> int:
	return boss_killed

func set_boss_killed(_boss_killed) -> void:
	boss_killed = _boss_killed