extends Component

class_name ChronoCalculComponent

var chrono : ChronoComponent = null

func get_Chrono() -> ChronoComponent:
	return chrono

func init(_chrono : ChronoComponent) -> void:
	chrono = _chrono
