extends System

class_name MoveSystem

const gravity = 1300

func _get_used_components() -> Array:
	return [ComponentsLibrary.Position,ComponentsLibrary.Movement]

func _process_node(dt : float, components : Dictionary) -> void:
	
	var move_comp = components[ComponentsLibrary.Movement] as MovementComponent
	var pos_comp = components[ComponentsLibrary.Position] as PositionComponent
	
	var velocity = Vector2(0,0)
	velocity.x = 0
	velocity.y += gravity * dt

	if move_comp.get_direction() == move_comp.dir.right :
		velocity.x += 250
		
	if move_comp.get_direction() == move_comp.dir.left :
		velocity.x -= 250
		
	if move_comp.is_jumping() == true :
		velocity.y = -600 
#		move_comp.get_node().move_and_slide(velocity,Vector2(0,-1))
		
	var dp = dt * velocity
	pos_comp.set_position(pos_comp.get_position() + dp)
	
	
	
