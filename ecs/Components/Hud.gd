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
var original_health : int = 0
var target_health : int = 0
var health_anim_time : float = 5
var health_current_anim_time : float = 0

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
	original_health = health_value.value
	target_health = original_health


func init_enemy(health_value : TextureProgress, health_label : Label, health_max : TextureProgress, 
				damage : Label, tween : Tween) -> void:
	_health_value = health_value
	_health_label = health_label
	_health_max = health_max
	_damage = damage
	_tween = tween
	original_health = health_value.value
	target_health = original_health

func init_stats(good_answer : Label, wrong_answer : Label, victories : Label, defeats : Label) -> void:
	_good_answer = good_answer
	_wrong_answer = wrong_answer
	_victories = victories
	_defeats = defeats

func update_displayed_health(dt : float) -> void:
	if original_health != target_health:
		health_current_anim_time = min(health_anim_time, health_current_anim_time + dt)
		_health_value.value = lerp(original_health, target_health, health_current_anim_time/health_anim_time)
		if health_current_anim_time == health_anim_time :
			original_health = target_health
		

func set_health(health : int) -> void :

	if health != target_health:
		target_health = health
		health_current_anim_time = 0
	
	if _health_value.value > 0:
		_health_label.text = "%s / %s" % [health,  _health_max.max_value]	
	if _health_value.value <= 0:
		_health_label.text = str(0)
	
#	var global_ratio = (health  / _health_max.max_value) 	
#	if global_ratio >= 0.75 :
#		var yellow = Color("f1ff08")
#		var green = Color("14e114")
#		var local_ratio = 4*global_ratio - 3
#		var color = lerp(yellow, green, local_ratio)
#		var 
#		_health_value.set_tint_progress(color)		
#	elif ratio >= 0.5 and ratio < 0.75 :
#		_health_value.set_tint_progress("f1ff08")		
#	elif ratio >= 0.25 and ratio < 0.5 :
#		_health_value.set_tint_progress("ffad00")		
#	elif ratio <  0.25 :
#		_health_value.set_tint_progress("e11e1e") 




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








