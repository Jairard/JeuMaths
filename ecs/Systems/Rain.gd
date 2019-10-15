extends System

class_name RainSystem

func _get_used_components() -> Array:
	return [ComponentsLibrary.Rain, ComponentsLibrary.Movement]
	

func _process_node(dt : float, components : Dictionary) -> void:
	var move_comp = components[ComponentsLibrary.Movement] 	as MovementComponent
	var rain_comp = components[ComponentsLibrary.Rain] 		as RainComponent

	var node : Node2D 	= rain_comp.get_node()
#	var node_instance : Object = node.instance()
				
#	var screen_size = get_viewport().size
#	var screen_tile = Vector2(screen_size.x, screen_size.y) / Vector2(64,64)
	var interval = rain_comp.x_max - rain_comp.x_min
	var unique = []
	var i : int = 0 
	for x in range(0,interval,20):
		unique.append([])
		if randi() % 2 == 1 :
			unique[i].append(node)
		
#			node.instance()
#			node.set_position(Vector2(100,100))
		i += 1
	rain_comp.spawn_rain(unique)
#			rain_comp.add_child(node_instance)
#			i.start(Vector2(x_pos * 64 , 0), randi() % 3)
#			add_child(i)

