extends Component

class_name HudComponent

var _health_value  	: 	TextureProgress = null
var _health_label 	: 	Label = null
var _health_max 	: 	TextureProgress = null
var _damage			: 	Label = null
var _xp_value 		: 	TextureProgress = null
var _level 			:	Label = null
var _treasure 		:	Label = null

func init_hero(health_value : TextureProgress, health_label : Label,
			   health_max : TextureProgress, damage : Label, xp_value : TextureProgress, 
			   level : Label, treasure : Label) -> void : #init node on map level
			
	_health_value = health_value
	_health_label = health_label
	_health_max = health_max
	_damage = damage
	_xp_value = xp_value
	_level = level
	_treasure= treasure

func init_enemy(health_value : TextureProgress, health_max : TextureProgress, health_label : Label, damage : Label) -> void:
	_health_value = health_value
	_health_label = health_label
	_health_max = health_max
	_damage = damage
 	
func set_health(value : int) -> void :		
	_health_value.value = value
#	print ("value : ", value)
	_health_label.text = str(value)
	
func set_damage(value : int) -> void :
	_damage.text = str(value)
	
func set_xp(value : int) -> void :
	_xp_value.value = value
	
func set_level(value : int) -> void :
	_level.text =str(value)
	
func set_treasure(value : int) -> void :
	_treasure.text = str(value)
	
	
	
	
	
	
	
	

