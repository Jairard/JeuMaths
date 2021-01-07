extends Component

class_name HudStatsPopupComponent

var _good_answer : Label = null
var _wrong_answer : Label = null
var _victories : Label = null
var _defeats : Label = null

func init_stats(good_answer : Label, wrong_answer : Label, victories : Label, defeats : Label) -> void:
	_good_answer = good_answer
	_wrong_answer = wrong_answer
	_victories = victories
	_defeats = defeats

func set_good_answer(value : int) -> void:
	_good_answer.text = str(value)

func set_wrong_answer(value : int) -> void:
	_wrong_answer.text = str(value)

func set_victories(value : int) -> void:
	_victories.text = str(value)

func set_defeats(value : int) -> void:
	_defeats.text = str(value)
