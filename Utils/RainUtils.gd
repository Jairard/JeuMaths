extends Node

func spawn_at(_min : int, _max : int, spacing : int, altitude : int, root : Node2D, resource : Resource):		# add resource for cloud
	if root != null:
		for x in range(_min, _max, spacing):
			var node = resource.instance()
			root.add_child(node)
			ECS.add_component(node, ComponentsLibrary.Movement)
			ECS.add_component(node, ComponentsLibrary.Velocity)
			var pos_comp = ECS.add_component(node, ComponentsLibrary.Position) as PositionComponent
			pos_comp.set_position(Vector2(x,altitude))
			var gravity_comp = ECS.add_component(node, ComponentsLibrary.Gravity) as GravityComponent
			gravity_comp.set_gravity(5)
