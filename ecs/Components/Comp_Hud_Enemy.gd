extends Component

class_name HudEnemyComponent

var _health_value  	: 	TextureProgress = null
var _health_label 	: 	Label = null
var _health_max 	: 	TextureProgress = null


func init(health_value : TextureProgress, health_label : Label,
			   health_max : TextureProgress) -> void:
	_health_value = health_value
	_health_label = health_label
	_health_max = health_max

func set_health(value : int) -> void :
	_health_value.value = value
	_health_label.text = str(value)
