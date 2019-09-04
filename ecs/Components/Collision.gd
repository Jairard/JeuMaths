extends Component

class_name CollisionComponent

var collisions : Array = []
var collisions_shape : Array = []

func get_collisions() -> Array :
	return collisions
	
func set_collisions(value : Array) -> void :
	collisions = value
	
func get_collisions_area() -> Array :
	return collisions_shape

func set_collisions_shape(value : Array) -> void :
	collisions_shape = value

