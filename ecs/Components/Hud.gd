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
var _tween : Tween = null

func init_hero_treasure(treasure : Label) -> void:
	_treasure = treasure

func init_hero_fight(treasure : Label, score_label : RichTextLabel) -> void:				#init node on map fight 1
	_treasure= treasure
	_score_label = score_label

func init_hero_map(health_value : TextureProgress, health_label : Label,
				   health_max : TextureProgress, damage : Label, tween : Tween) -> void : 		#init node on map fire/water		
	_health_value = health_value
	_health_label = health_label
	_health_max = health_max
	_damage = damage
	_tween = tween


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

func set_health(health : int) -> void :
#	var current_value = _health_value.value - 10
#	_tween.interpolate_property(_health_value, "value", current_value, value, 0.5, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
#	_tween.start()
	_health_value.value = health
#	print ("value : ", value)
#	_health_label.text = str(health)
	_health_label.text = "%s / %s" % [health,  _health_max.value]	
	print ("max : ", _health_max.value) 
	var percent = (health  / _health_max.value) * 100
#	print ("% : ", percent)		
	if percent >= 0.8 * _health_max.value:
		_health_value.set_tint_progress("14e114")
	elif percent >= 0.5 * _health_max.value and percent < 0.8 * _health_max.value:
		_health_value.set_tint_progress("f1ff08")		
	elif percent >= 0.2 * _health_max.value and percent < 0.5 * _health_max.value:
		_health_value.set_tint_progress("e1be32")		
	elif percent <  0.2 * _health_max.value:
		_health_value.set_tint_progress("e11e1e") 


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








