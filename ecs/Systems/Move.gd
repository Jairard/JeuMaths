extends System

class_name MoveSystem

const gravity = 1300
const jump_impulse = -600
const lateral_velocity = 250
var velocity : Vector2 = Vector2(0, 0)

func _get_used_components() -> Array:
	return [ComponentsLibrary.Position,ComponentsLibrary.Movement]

func _process_node(dt : float, components : Dictionary) -> void:
	var move_comp = components[ComponentsLibrary.Movement] as MovementComponent
	var pos_comp = components[ComponentsLibrary.Position] as PositionComponent
	
	velocity.x = 0
	velocity.y += gravity * dt

	if move_comp.get_direction() == move_comp.dir.right :
		velocity.x = lateral_velocity
		
	if move_comp.get_direction() == move_comp.dir.left :
		velocity.x = -lateral_velocity
		
	if move_comp.is_jumping() == true:
		velocity.y = jump_impulse
		move_comp.set_is_jumping(false)
		
	var dp = dt * velocity
	print("dt=" + str(dt) + ", currentPos=" + str(pos_comp.get_position()) + ", dp=" + str(dp), ", velocity=" + str(velocity))
	pos_comp.move_and_slide(velocity)
