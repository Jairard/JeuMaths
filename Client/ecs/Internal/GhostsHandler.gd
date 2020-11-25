class_name GhostsHandler

var components : Dictionary = {} # Dictionary(String -> Dictionary(Resource -> Component))

func create_ghost_IFN(comp : Component, res : Resource) -> bool:
	var create_ghost = comp.has_tag()
	if (!create_ghost):
		return false

	var tag = comp.get_tag()
	if (!components.has(tag)):
		components[tag] = {}

	var tag_components = components[tag]
	if (tag_components.has(res)):
		EcsUtils.log_and_push_error("GhostsHandler.create_ghost_IFN: there is already a registered component of type  " + res.resource_path + " for tag '" + tag + "'. This component will be destroyed")
		return false

	tag_components[res] = comp
	comp.__mark_as_ghost()
	return true

func steal_ghost(id : int, res : Resource, tag : String) -> Component:
	var component : Component = null
	if (components.has(tag)):
		var tag_components = components[tag]
		if (tag_components.has(res)):
			component = tag_components[res]
			component.__set_object_id(id)
			tag_components.erase(res)

	return component

func clear() -> void:
	for tag in components.keys():
		remove_ghosts(tag)
	components.clear()

func remove_ghosts(tag : String) -> void:
	if (components.has(tag)):
		for comp in components[tag].values():
			comp.free()
	components.erase(tag)
