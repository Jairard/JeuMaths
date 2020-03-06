extends Component

class_name HudComponent

var _health_value  	: 	TextureProgress = null
var _health_label 	: 	Label = null
var _health_max 	: 	TextureProgress = null
var _damage			: 	Label = null
var _treasure 		:	Label = null
var _score_label	:   RichTextLabel = null
var _score 			: int = 0
var _good_answer : Label = null
var _wrong_answer : Label = null
var _victories : Label = null
var _defeats : Label = null

func init_hero_treasure(treasure : Label) -> void:
	_treasure = treasure

func init_hero_fight(treasure : Label, score_label : RichTextLabel) -> void:				#init node on map fight 1
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

func init_stats(good_answer : Label, wrong_answer : Label, victories : Label, defeats : Label) -> void:
	_good_answer = good_answer
	_wrong_answer = wrong_answer
	_victories = victories
	_defeats = defeats

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
	if value != _score:
		_score_label.set_bbcode("[wave][rainbow]"+str(value))
		_score = value

func set_good_answer(value : int) -> void:
#	_good_answer.text = str(value)
	pass
	
func set_wrong_answer(value : int) -> void:
#	_wrong_answer.text = str(value)
	pass

func set_victories(value : int) -> void:
#	_victories.text = str(value)
	pass

func set_defeats(value : int) -> void:
#	_defeats.text = str(value)
	pass








