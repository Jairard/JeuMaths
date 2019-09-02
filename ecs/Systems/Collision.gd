extends System

class_name CollisionSystem


func _get_used_components() -> Array:
	return [ComponentsLibrary.Collision, ComponentsLibrary.Position]

func _process_node(dt : float, components : Dictionary) -> void:
	
	var comp = components[ComponentsLibrary.Collision] as CollisionComponent
	var pos_comp = components[ComponentsLibrary.Position] as PositionComponent

	var hero_Node  = comp.get_node()
	var hero_Node_coll = hero_Node.get_node("hero_coll")
	var hero_pos = hero_Node_coll.get_position()
	print (hero_pos)
	

#	var enemy_Node = comp.get_node()
#	var enemy_Node_coll = enemy_Node.get_node("CollisionShape2D")
#	var enemy_pos = enemy_Node.get_position()
	
#	print (hero_Node)
#	print (enemy_Node)
	pass
#	if pos_comp.move_and_slide(pos_comp.get_position()) :
#		print ("collision") 
	
#	pos_comp.set_position(pos_comp.get_position() + dp)