extends Component

class_name TreasureComponent

var treasure = 0

func init(current_treasure : int) -> void :
	if (!was_ghost()):
		treasure = current_treasure

func get_treasure() -> int :
	return treasure

func set_treasure(value : int) -> void :
	treasure = value
