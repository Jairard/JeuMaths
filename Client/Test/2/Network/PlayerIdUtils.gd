extends Node

const elemCount = 4
const separator = "-"

# This transforms an instance of PlayerId to a string composed of 4 parts.
# Each part contains 4 hexadecimal digits and is separated from other parts by a dash.
# Example of output:
#     abcd-0535-5f6e-88ab
func get_string(id : PlayerId) -> String:
	return "%04x%s%04x%s%04x%s%04x" % [id.teacherId, separator, id.schoolId, separator, id.classId, separator, id.studentId]

func foo():
	pass

# This creates a PlayerId instance from a correctly formed string,
# as described in the previous function.
func create_from_string(s : String) -> PlayerId:
	# First we split the string and check that there is enough parts
	var elem = s.split(separator)
	if len(elem) != elemCount:
		return null

	# Then we translate the hexadecimal values to integers
	var values : Array = []
	for i in range(elemCount):
		var with_prefix = "0x" + elem[i]
		var id = with_prefix.hex_to_int()
		if id == 0: # hex_to_int returns 0 if it fails
			return null
		values += [id]

	# Finally we create the corresponding PlayerId
	return PlayerId.new(values[0], values[1], values[2], values[3])

