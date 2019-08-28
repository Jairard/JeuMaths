extends System

class_name CollisionSystem


func _get_used_components() -> Array:
	return [ComponentsLibrary.Collision, ComponentsLibrary.Position]

func _process_node(dt : float, components : Dictionary) -> void:
	
	var comp = components[ComponentsLibrary.Collision] as CollisionComponent
	var pos_comp = components[ComponentsLibrary.Position] as PositionComponent
#
#	var hero_Node  = comp.get_node()
#	var hero_Node_coll = hero_Node.get_node("hero_coll")
#	var hero_pos = hero_Node.get_position()
	

#	var enemy_Node = comp.get_node()
#	var enemy_Node_coll = enemy_Node.get_node("CollisionShape2D")
#	var enemy_pos = enemy_Node.get_position()
	
#	print (hero_Node)
#	print (enemy_Node)
	pass
#	if hero_pos.move_and_collide() :
#		print ("collision") 
#
##	var test = hero_Node_coll.
#		print ("test")
#	pass

	
#	pos_comp.set_position(pos_comp.get_position() + dp)