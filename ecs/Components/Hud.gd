extends Component

class_name HudComponent

var _health_value  	: 	TextureProgress = null
var _health_label 	: 	Label = null
var _health_max 	: 	TextureProgress = null
var _damage			: 	Label = null
var _treasure 		:	Label = null
var _score_label	:   RichTextLabel = null

func init_hero_fight(treasure : Label, score_label : RichTextLabel):				#init node on map fight 1
	_treasure= treasure
	_score_label = score_label

func init_hero_map(health_value : TextureProgress, health_label : Label,
				   health_max : TextureProgress, damage : Label) -> void : 		#init node on map fire/water		
	_health_value = health_value
	_health_label = health_label
	_health_max = health_max
	_damage = damage


func init_enemy(health_value : TextureProgress, health_label : Label, health_max : TextureProgress, damage : Label) -> void:
	_health_value = health_value
	_health_label = health_label
	_health_max = health_max
	_damage = damage

func set_health(value : int) -> void :
	_health_value.value = value
#	print ("value : ", value)
	_health_label.text = str(value)

func set_health_max(value : int) -> void:
	_health_max.max_value = value

func set_damage(value : int) -> void :
	_damage.text = str(value)

func set_treasure(value : int) -> void :
	_treasure.text = str(value)

func set_score(value : int) -> void :
	_score_label.append_bbcode(str(value))









