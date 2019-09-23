extends System

class_name MoveAnswerSystem

func _get_used_components() -> Array:
	return [ComponentsLibrary.Movement, ComponentsLibrary.Position, ComponentsLibrary.Velocity]

#func _get_system_dependencies() -> Array:
#	return [SystemsLibrary.Position]

func _process_node(dt : float, components : Dictionary) -> void:
	var loot_comp 	= 	components[ComponentsLibrary.Movement]			as  MovementComponent
	var node_comp 	= 	components[ComponentsLibrary.Position]		 	as  PositionComponent

	
	
	