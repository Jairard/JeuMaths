extends System

class_name MissileSystem

var velocity : Vector2
var speed : int = 150

func _get_used_components() -> Array:
	return [ComponentsLibrary.Movement, ComponentsLibrary.Missile, ComponentsLibrary.Position]

func _process_node(dt : float, components : Dictionary) -> void:
	var move_comp		 = 	components[ComponentsLibrary.Movement] as MovementComponent
	var pos_comp		 = 	components[ComponentsLibrary.Position] as PositionComponent
	var misl_comp		 = 	components[ComponentsLibrary.Missile]  as  MissileComponent

	var dp = velocity * dt 
	
	if misl_comp.missile == true :
		
		var target = move_comp.get_node().get_parent().get_node("hero")			# Target position
		var target_pos = target.position									
		
		var shooter = misl_comp.get_node()										# Shooter position 
		var shooter_pos = shooter.position
#		print (shooter_pos)

		var navigation = misl_comp.get_node().get_parent().get_node("Navigation2D")
		var path : PoolVector2Array = navigation.get_simple_path(shooter_pos, target_pos, false)
		
		var direction = target_pos - shooter_pos 
		
		var angle = direction.angle() 
		var angl = rad2deg(angle)

		misl_comp.get_node().set_rotation_degrees( angl)
			
		if path.size() != 0 : 
			velocity = path[1] - shooter_pos

		pos_comp.move_and_slide(velocity.normalized() * speed)