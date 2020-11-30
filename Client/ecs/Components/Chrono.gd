extends Component

class_name ChronoComponent

var associated_answer : String = ""
var answer : String = ""
var new_answer = false
var new_question = false
var gold : int = 0
var delete_nodes = false
var discolor_nodes = false
var answer_count : int = 1

func get_associated_answer() -> String:
	return associated_answer

func set_associated_answer(value : String) -> void:
	associated_answer = value

func get_answer() -> String:
	return answer

func set_answer(value : String) -> void:
	answer = value

func get_answer_count() -> int:
	return answer_count

func set_answer_count(value : int) -> void:
	answer_count = value

func get_discolor_nodes() -> bool:
	return discolor_nodes

func set_discolor_nodes(value : bool) -> void:
	discolor_nodes = value
	
func get_delete_nodes() -> bool:
	return delete_nodes

func set_delete_nodes(value : bool) -> void:
	delete_nodes = value
	
func get_new_answer() -> bool:
	return new_answer

func set_new_answer(value : bool) -> void:
	new_answer = value

func get_new_question() -> bool:
	return new_question

func set_new_question(value : bool) -> void:
	new_question = value
	
func get_gold() -> int:
	return gold

func set_gold(value : int) -> void:
	gold = value
