extends Node

func spawn_at(_min : int, _max : int, spacing : int, altitude : int, root : Node2D, resource : Resource):		# add resource for cloud
	if root != null:
		for x in range(_min, _max, spacing):
			var node = resource.instance()
			root.add_child(node)
			ECS.add_component(node, ComponentsLibrary.Movement)
			var pos_comp = ECS.add_component(node, ComponentsLibrary.Position) as PositionComponent
			pos_comp.set_position(Vector2(x,altitude))