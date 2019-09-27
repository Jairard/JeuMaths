extends System

class_name MissileSystem

var velocity : Vector2
var speed : int = 150

func _get_used_components() -> Array:
	return [ComponentsLibrary.Nodegetid, ComponentsLibrary.Position , ComponentsLibrary.Movement]

func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Move]

func _process_node(dt : float, components : Dictionary) -> void:
	var pos_comp		 = 	components[ComponentsLibrary.Position] 	 	 as  PositionComponent
	var misl_comp		 = 	components[ComponentsLibrary.Nodegetid] 	 as  NodegetidComponent
	var move_comp		 = 	components[ComponentsLibrary.Movement] 		 as  MovementComponent
	
	var dp = velocity * dt 
	
	var target_pos_comp = _getComponentOfEntity(misl_comp.get_target_id(), ComponentsLibrary.Position)
	if target_pos_comp != null :
		var target_pos = target_pos_comp.get_position() # Target Position
		var shooter_pos = pos_comp.get_position()       # Shooter position
		print (shooter_pos)
		MoveUtils.set_direction(target_pos, shooter_pos)
		# Compute path and move
		var node_navigation = misl_comp.get_node().get_parent().get_node("Navigation2D")
		var dir = MoveUtils.get_direction_to(target_pos, shooter_pos, node_navigation)

		# Compute orientation

		if MoveUtils.direction.x >= -1500 :
			pos_comp.move_and_slide(dir * speed)
			var get_angle = MoveUtils.dir_to_angle(MoveUtils.get_direction())
			misl_comp.get_node().set_rotation_degrees(get_angle)
		
		else :
			pass
