extends Node

func remove_IFP(array : Array, elem : Object) -> bool:
	var idx = array.find(elem)
	var found = (idx != -1)
	if (found):
		array.remove(idx)

	return found
