extends System

class_name EmitParticulesSystem

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.EmitPArticules]

func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Endfight]

func _process_node(dt : float, components : Dictionary) -> void:
	var emit_comp		 = 	components[ComponentsLibrary.EmitPArticules] 	 	 as  EmitParticulesComponent
#	print ("emit comp : ", emit_comp.emit)
	if emit_comp.get_emit() == true:
		print ("2")
		var test_emit = emit_comp.get_node()
		if emit_comp.get_node("Particules2D") != null:
			print ("3")
			test_emit.get_node("Particles2D").emitting = true
