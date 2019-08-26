extends Component

class_name AnswerComponent

enum answer {true, false, none}
var answr = answer.none

func get_answer() : # -> answer 
	return answr
	
func set_answer(answer) -> void :
	answr = answer
	
