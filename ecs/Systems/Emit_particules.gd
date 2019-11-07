extends System

class_name EmitParticulesSystem

func _get_used_components() -> Array:
	return [ComponentsLibrary.EmitPArticules]

func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Move]

func _process_node(dt : float, components : Dictionary) -> void:
	var emit_comp		 = 	components[ComponentsLibrary.EmitPArticules] 	 	 as  EmitParticulesComponent
	
	if emit_comp.get_emit() == true:
		var test = emit_comp.get_node()
		test.get_node("Particles2D").emitting = true
