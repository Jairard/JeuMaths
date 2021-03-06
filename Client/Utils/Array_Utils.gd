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

func copy(array : Array) -> Array:
	var res : Array = []
	for elem in array:
		res.append(elem)
	return res

func inverted(array : Array) -> Array:
	var res = copy(array)
	res.invert()
	return res

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

func contains_doublon(array : Array) -> bool:
	for i in range(0, array.size()):
		for j in range(i+1, array.size()):
			if (array[j] == array[i]):
				return true
	return false

func get_doublon_indices(array : Array) -> Array:
	var indices: Array = []
	for i in range(0, array.size()):
		for j in range(i+1, array.size()):
			if (array[j] == array[i]):
				indices.append(j)
	return indices

func remove_doublons(array : Array) -> void:
	var doublons = inverted(get_doublon_indices(array))
	for i in doublons:
		array.remove(i)
