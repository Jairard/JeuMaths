extends System

class_name MoveSystem

onready var velocity = Vector2(0,0)

func _get_used_components() -> Array:
	return [ComponentsLibrary.Position]

func _process_node(dt : float, components : Dictionary) -> void:
	
	var comp = components[ComponentsLibrary.Movement] as MovementComponent
	var dp = dt * velocity
#	var sys = systems[SystemsLibrary.Systems] as InputSystems
	if comp.set_is_moving() :
		if Input.is_action_just_pressed("ui_right") :
			velocity = Vector2(60,0)
			comp.set_position(comp.get_position() + dp)
			comp.set_is_moving(true)
		elif Input.is_action_just_released("ui_right") : 
			comp.set_is_moving(false)
			
		if Input.is_action_just_pressed("ui_left") :
			velocity = Vector2(-60,0)
			comp.set_position(comp.get_position() + dp)
			comp.set_is_moving(true)
		elif Input.is_action_just_released("ui_left") : 
			comp.set_is_moving(false)

	
	

	

