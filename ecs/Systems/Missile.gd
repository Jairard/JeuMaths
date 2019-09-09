extends System

class_name MissileSystem

var velocity : Vector2
var speed : int = 150

func _get_used_components() -> Array:
	return [ComponentsLibrary.Missile, ComponentsLibrary.Position , ComponentsLibrary.Movement]

func _process_node(dt : float, components : Dictionary) -> void:
	var pos_comp		 = 	components[ComponentsLibrary.Position] 	 as  PositionComponent
	var misl_comp		 = 	components[ComponentsLibrary.Missile] 	 as  MissileComponent
	var move_comp		 = 	components[ComponentsLibrary.Movement] 	 as  MovementComponent
	
	var dp = velocity * dt 
	
	var target_pos_comp = _getComponentOfEntity(misl_comp.get_target_id(), ComponentsLibrary.Position)
	if target_pos_comp != null :
		var target_pos = target_pos_comp.get_position() # Target Position
		var shooter_pos = pos_comp.get_position()       # Shooter position

		# Compute path and move
		var node_navigation = misl_comp.get_node().get_parent().get_node("Navigation2D")		
#		var node_navigation = _getComponentOfEntity(
		move_comp.path(target_pos, shooter_pos, node_navigation) 		
		velocity = move_comp.velocity
		pos_comp.move_and_slide(velocity.normalized() * speed)

		# Compute orientation
		pos_comp.transform(target_pos, shooter_pos)
		misl_comp.get_node().set_rotation_degrees(pos_comp.angle_deg)
