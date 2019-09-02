extends System

class_name MoveSystem

const gravity = 1500
var velocity = Vector2(0,0)
var lateral_velocity = 250
var jump_impulse = -600

func _get_used_components() -> Array:
	return [ComponentsLibrary.Position, ComponentsLibrary.Movement, ComponentsLibrary.Collision]

func _process_node(dt : float, components : Dictionary) -> void:
	var move_comp = components[ComponentsLibrary.Movement] as MovementComponent
	var pos_comp = components[ComponentsLibrary.Position] as PositionComponent
	
	velocity.x = 0
	velocity.y += gravity * dt 

	if move_comp.get_direction() == move_comp.dir.right :
		velocity.x += lateral_velocity
		if pos_comp.move_and_slide(velocity) : 
			print ("collision")			
		
	if move_comp.get_direction() == move_comp.dir.left :
		velocity.x = -lateral_velocity

	if move_comp.is_jumping() == true and move_comp.get_node().is_on_floor():
		velocity.y = jump_impulse
		move_comp.set_is_jumping(false)
	
	pos_comp.move_and_slide(velocity)

	# Collision detection
	var col_comp = components[ComponentsLibrary.Collision] as CollisionComponent
	var body = pos_comp.get_node() as KinematicBody2D # Try to get the node as a kinematic body
	var collisions : Array = [] # The array in which we'll store the collisions

	if body != null: # If it succeeds, we can proceed
		var collision_count : int = body.get_slide_count() # get the collision count
		for i in range(collision_count):
			var current_collision = body.get_slide_collision(i) # For each collision,
			collisions.append(current_collision)                # we append it to the array

	# Give the information to the collision component.
	# If the node is not a kinematic body, the collisions are reset to an empty array
	col_comp.set_collisions(collisions)
