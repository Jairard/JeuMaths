extends System

class_name CollisionSystem

# There must be a cleaner way to do this
const hero_layer_bit : int = 0
const enemy_layer_bit : int = 2

func _get_used_components() -> Array:
	return [ComponentsLibrary.Collision, ComponentsLibrary.Position]

func _process_node(dt : float, components : Dictionary) -> void:
	var col_comp = components[ComponentsLibrary.Collision] as CollisionComponent
	var pos_comp = components[ComponentsLibrary.Position] as PositionComponent

	# Check if the node is a PhysicsBody2D
	var my_body = col_comp.get_node() as PhysicsBody2D
	if (my_body == null):
		return

	var collisions = col_comp.get_collisions()

	#instance_from_id
	for col in collisions:
		var collider = col.get_collider() as PhysicsBody2D
		if ((collider != null)                                                 # If the collider is valid
		    and (my_body.get_collision_layer_bit(hero_layer_bit) == true)      # AND we are the hero
			and (collider.get_collision_layer_bit(enemy_layer_bit) == true)):  # AND the collider is an enemy

			print("Enemy collision !") # Do something


