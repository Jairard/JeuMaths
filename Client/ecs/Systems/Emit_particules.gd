extends System

class_name EmitParticulesSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.EmitPArticules]

func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Endfight]

func _process_node(dt : float, components : Dictionary) -> void:
	var emit_comp		 = 	components[ComponentsLibrary.EmitPArticules] 	 	 as  EmitParticulesComponent

	if emit_comp.get_emit() == true:
		var test_emit = emit_comp.get_node()
		var parent = test_emit.get_parent()
		if parent.has_node("Particules2D") != null:
			test_emit.get_node("Particles2D").emitting = true
			emit_comp.set_emit(false)
