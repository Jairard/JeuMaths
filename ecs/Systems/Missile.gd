extends System

class_name MissileSystem

var speed : int = 150

func _get_used_components() -> Array:
	return [ComponentsLibrary.Nodegetid, ComponentsLibrary.Position]

func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Move]

func _process_node(dt : float, components : Dictionary) -> void:
	var pos_comp		 = 	components[ComponentsLibrary.Position] 	 	 as  PositionComponent
	var misl_comp		 = 	components[ComponentsLibrary.Nodegetid] 	 as  NodegetidComponent
	var node : Node2D = pos_comp.get_node() as Node2D
	var target_pos_comp = _getComponentOfEntity(misl_comp.get_target_id(), ComponentsLibrary.Position)

	if target_pos_comp != null :
		
		var target_pos = EcsUtils.get_absolute_position(target_pos_comp) # Hero Position
		var missile_pos = EcsUtils.get_absolute_position(pos_comp)       # Missile position
		DebugUtils.add_line(target_pos, missile_pos, Color.orange,1)
		
		# Compute path and move
		var node_navigation = misl_comp.get_node().get_parent().get_node("Navigation2D")
		var dir_to = MoveUtils.get_direction_to(target_pos, missile_pos, node_navigation)
		DebugUtils.add_line(missile_pos, missile_pos + dir_to * speed, Color.blue,1)
		var dir = target_pos - missile_pos														
		# Compute orientation
#		if  dir.x >= -1500 :
			
		pos_comp.move_and_slide(dir_to * speed)
		var get_angle = MoveUtils.dir_to_angle(dir)
#		pos_comp.get_node().set_rotation_degrees(get_angle)
#
#		else :
#			pass
