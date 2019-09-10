extends Node

func remove_IFP(array : Array, elem : Object) -> bool:
	var idx = array.find(elem)
	var found = (idx != -1)
	if (found):
		array.remove(idx)

	return found

func contains(array: Array, elem : Object) -> bool:
	var idx = array.find(elem)
	return (idx != -1)

# Return true is all the elements of `src` are also in `dst`
func is_included_in(src: Array, dst : Array) -> bool:
	for elem in src:
		var idx = dst.find(elem)
		if (idx == -1):
			return false
	return true

# Return the elements that are in `src` but not in `dst`
func get_diff(src : Array, dst : Array) -> Array:
	var res : Array = []

	for elem in src:
		var idx = dst.find(elem)
		if (idx == -1):
			res.push_back(elem)

	return res
