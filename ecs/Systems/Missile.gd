extends System

class_name MissileSystem

var velocity : Vector2
var speed : int = 150

func _get_used_components() -> Array:
	return [ComponentsLibrary.Missile, ComponentsLibrary.Position]

func _process_node(dt : float, components : Dictionary) -> void:
	var pos_comp		 = 	components[ComponentsLibrary.Position] as PositionComponent
	var misl_comp		 = 	components[ComponentsLibrary.Missile]  as  MissileComponent

	var dp = velocity * dt 
	
	var target_pos_comp = _getComponentOfEntity(misl_comp.get_target_id(), ComponentsLibrary.Position)
	if target_pos_comp != null :
		var target_pos = target_pos_comp.get_position() # Target Position
		var shooter_pos = pos_comp.get_position()       # Shooter position

		# Compute path and move
		# TODO: we should have a component for that (maybe in the Move component ?)
		var navigation = misl_comp.get_node().get_parent().get_node("Navigation2D")
		var path : PoolVector2Array = navigation.get_simple_path(shooter_pos, target_pos, false)
		if path.size() != 0 :
			velocity = path[1] - shooter_pos
		pos_comp.move_and_slide(velocity.normalized() * speed)

		# Compute orientation
		var direction = target_pos - shooter_pos 
		var angle = direction.angle() 
		var angl = rad2deg(angle)
		# TODO: this should be done via a component (Position -> Transform)
		misl_comp.get_node().set_rotation_degrees( angl)
