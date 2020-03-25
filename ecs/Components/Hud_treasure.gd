extends Component

class_name HudTreasureComponent

var _treasure 		:	Label = null

func init_treasure(treasure : Label, gold : int) -> void:
	_treasure = treasure
	_treasure.text = str(gold)
	
func set_treasure(value : int) -> void :
	_treasure.text = str(value)
