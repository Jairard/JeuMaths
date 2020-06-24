extends Component

class_name HudInvaderComponent

var gold 		:	Label = null

func init(_gold : Label) -> void:				
	gold= _gold

func set_gold(value : int) -> void :
	gold.text = str(value)
