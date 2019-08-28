extends System

class_name MoveSystem

const gravity = 1300
var velocity : Vector2 = Vector2(0, 0)

func _get_used_components() -> Array:
	return [ComponentsLibrary.Position,ComponentsLibrary.Movement]

func _process_node(dt : float, components : Dictionary) -> void:
	
	var move_comp = components[ComponentsLibrary.Movement] as MovementComponent
	var pos_comp = components[ComponentsLibrary.Position] as PositionComponent
	
	velocity.x = 0
	velocity.y += gravity * dt

	if move_comp.get_direction() == move_comp.dir.right :
		velocity.x += 250
		
	if move_comp.get_direction() == move_comp.dir.left :
		velocity.x -= 250
		
	if move_comp.is_jumping() == true:
		velocity.y = -600
		move_comp.set_is_jumping(false)
		
	var dp = dt * velocity
	
	
	
	pos_comp.move_and_slide(velocity)
