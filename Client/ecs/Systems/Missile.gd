extends System

class_name MissileSystem

var speed : int = 150

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Nodegetid, ComponentsLibrary.Position]

func _get_optional_components() -> Array:
	return [ComponentsLibrary.Rotation]

func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Move]

func _process_node(dt : float, components : Dictionary) -> void:
	var pos_comp		 = 	components[ComponentsLibrary.Position] 	 	 as  PositionComponent
	var misl_comp		 = 	components[ComponentsLibrary.Nodegetid] 	 as  NodegetidComponent
	var target_pos_comp  = _getComponentOfEntity(misl_comp.get_target_id(), ComponentsLibrary.Position)
	var rotation_comp   =  components[ComponentsLibrary.Rotation]		 as  RotationComponent

	if target_pos_comp != null :

		var target_pos = EcsUtils.get_absolute_position(target_pos_comp) # Hero Position
		var missile_pos = EcsUtils.get_absolute_position(pos_comp)       # Missile position
#		DebugUtils.add_line(target_pos, missile_pos, Color.orange,1)

		# Compute path and move
		var parent = misl_comp.get_node().get_parent()
		var node_navigation = null
		if (parent.has_node("Navigation2D")):
			node_navigation = parent.get_node("Navigation2D")
		var dir_to = MoveUtils.get_direction_to(target_pos, missile_pos, node_navigation)
#		DebugUtils.add_line(missile_pos, missile_pos + dir_to * speed, Color.blue,1)
		var dir = target_pos - missile_pos

		# Compute orientation
		if rotation_comp != null and dir.x >= -1500 :
			pos_comp.move_and_slide(dir_to * speed)
			var get_angle = MoveUtils.dir_to_angle(dir)
			pos_comp.get_node().set_rotation_degrees(get_angle)

		else :
			pos_comp.move_and_slide(dir_to * speed * 10)
