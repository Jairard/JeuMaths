extends Component

class_name HudFightComponent

var _health_value  	: 	TextureProgress = null
var _health_label 	: 	Label = null
var _damage			: 	Label = null
var original_health : int = 0
var target_health : int = 0

var health_anim_time : float = 5
var health_current_anim_time : float = 0


func init_hero(health_value : TextureProgress, health_label : Label,
				   damage : Label, initial_health : int, initial_health_max : int) -> void : 		#init node on map fire/water		
	_health_value = health_value
	_health_label = health_label
	_damage = damage
	_health_value.max_value = initial_health_max
	_health_value.value = initial_health
	original_health = initial_health
	target_health = original_health
#	print ("original hero : ", original_health, "  /  target : ", target_health)	
	

func init_enemy(health_value : TextureProgress, health_label : Label, 
				damage : Label, initial_health : int, initial_health_max : int) -> void:
	_health_value = health_value
	_health_label = health_label
	_health_value.max_value = initial_health_max
	_health_value.value = initial_health
	_damage = damage
	original_health = initial_health
	target_health = original_health
#	print ("original enemy : ", original_health, "  /  target : ", target_health)
	

func update_displayed_health(dt : float) -> void:
	if original_health != target_health:
		health_current_anim_time = min(health_anim_time, health_current_anim_time + dt)
		_health_value.value = lerp(original_health, target_health, health_current_anim_time/health_anim_time)
		if health_current_anim_time == health_anim_time :
			original_health = target_health
		

func set_health(health : int) -> void :
	if health != target_health:
#		print ("health : ", health, "  /  target : ", target_health)		
		target_health = health
		health_current_anim_time = 0
	
	if _health_value.value > 0:
		_health_label.text = "%s / %s" % [health,  _health_value.max_value]	
	if _health_value.value <= 0:
		_health_label.text = str(0)
	
	var global_ratio = (health  / _health_value.max_value) 	
	var yellow = Color("f1ff08")
	var green = Color("14e114")
	var orange = Color("ffad00")
	var red = Color("e11e1e")
	var black = Color("000000")

	if global_ratio >= 0.75:
#		print (global_ratio)
		var local_ratio = 4*global_ratio - 3
		var color = lerp(yellow, green, local_ratio)
		_health_value.set_tint_progress(color)

	elif global_ratio >= 0.5 and global_ratio < 0.75 :
		var local_ratio = 4*global_ratio - 2
		var color = lerp(orange, yellow, local_ratio)
		_health_value.set_tint_progress(color)

	elif global_ratio >= 0.25 and global_ratio < 0.5 :
		var local_ratio = 4*global_ratio - 1
		var color = lerp(red, orange, local_ratio)
		_health_value.set_tint_progress(color) 
			
	elif global_ratio < 0.25 :
		var local_ratio = 4*global_ratio 
		var color = lerp(black, red, local_ratio)
		_health_value.set_tint_progress(color) 


func set_health_max(value : int) -> void:
	_health_value.max_value = value

func set_damage(value : int) -> void :
	_damage.text = str(value)
