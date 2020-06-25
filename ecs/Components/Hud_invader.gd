extends Component

class_name HudInvaderComponent

var gold 		:	Label 	= null
var sprite_array : Array = []

func init(_gold : Label, hud_root : Node2D) -> void:
	gold= _gold
	var i = 1
	while true:
		var nodeName : String = "health" +  str(i)
		var sprite : Sprite = hud_root.get_node(nodeName)
		if sprite != null:
			sprite_array.append(sprite)
			i += 1
		else:
			break

func set_gold(value : int) -> void :
	gold.text = str(value)

func set_health(value : int) -> void:
	for i in range(len(sprite_array)):
		if i < value:
			sprite_array[i].show()
		else:
			sprite_array[i].hide()
