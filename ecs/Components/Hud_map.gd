extends Component

class_name HudMapComponent

var _treasure 		:	Label = null
var _score_label	:   RichTextLabel = null
var _score : int= 0

func init_hero(treasure : Label, gold : int,  score_label : RichTextLabel, score : int) -> void:				#init node on map fight 1
	_treasure= treasure
	_treasure.text = str(gold)
	
	_score = score
	_score_label = score_label
	_score_label.set_bbcode("[wave][rainbow]"+str(score))

func set_treasure(value : int) -> void :
	_treasure.text = str(value)
		
func set_score(value : int) -> void :
	if value != _score:
		_score_label.set_bbcode("[wave][rainbow]"+str(value))
		_score = value
