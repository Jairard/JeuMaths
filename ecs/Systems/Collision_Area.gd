extends System

class_name CollisionAreaSystem

const test1 = 0
const test2 = 2

func _get_used_components() -> Array:
	return [ComponentsLibrary.Collision, ComponentsLibrary.Position]

func _process_node(dt : float, components : Dictionary) -> void:
	var col_comp = components[ComponentsLibrary.Collision] as CollisionComponent
	var pos_comp = components[ComponentsLibrary.Position] as PositionComponent
	
	var my_body = col_comp.get_node() 
	var my_body_area = my_body.get_node("hero_coll") as Area2D
	if (my_body == null):
		return

	var coll_shape = col_comp.get_collisions_area()
#	print (coll_shape)

	for col in coll_shape:
		var collshape =  col.get_collider() as Area2D	
		if ((collshape != null)                                                 # If the collider is valid
		    and (my_body_area.get_collision_mask_bit(test1) == true)      # AND we are the hero
			and (collshape.get_collision_mask_bit(test2) == true)):  # AND the collider is an enemy

			print("Area collision !") # Do something

