extends System

class_name MissileSystem

var velocity : Vector2
var speed : int = 100

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
		print (shooter_pos)
					
		velocity = target_pos - shooter_pos 
#		print (velocity)
		
#		pos_comp.set_position(pos_comp.get_position() + dp / 5)
		pos_comp.move_and_slide(velocity.normalized() * speed)