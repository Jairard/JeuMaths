extends Component

class_name HudComponent

var test  : TextureProgress = null
var test2 : Label = null

func init(health_hero : TextureProgress, label_hero : Label) -> void : #init node on map level
	test = health_hero
	test2 = label_hero
	
 	
func set_health(value : int) -> void :		
	test.value = value
	test2.text = str(value)

