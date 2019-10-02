extends System

class_name MoveSystem

const gravity = 100
var velocity = Vector2(0,0)
var lateral_velocity = 250
var jump_impulse = -900

func _get_used_components() -> Array:
	return [ComponentsLibrary.Position, ComponentsLibrary.Movement]

func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Input]

func _process_node(dt : float, components : Dictionary) -> void:
	var move_comp = components[ComponentsLibrary.Movement] as MovementComponent
	var pos_comp = components[ComponentsLibrary.Position] as PositionComponent
	
	velocity.x = 0
	velocity.y += gravity * dt 

	if move_comp.get_direction() == move_comp.dir.right :
		velocity.x += lateral_velocity
		
	if move_comp.get_direction() == move_comp.dir.left :
		velocity.x = -lateral_velocity

	if move_comp.is_jumping() == true and move_comp.get_node().is_on_floor():
		velocity.y = jump_impulse
		move_comp.set_is_jumping(false)
	
	pos_comp.move_and_slide(velocity)
	
	
