extends Component

class_name CollisionComponent

var collisions : Array = []
var collisions_shape : Array = []

func get_collisions() -> Array :
	return collisions
	
func set_collisions(value : Array) -> void :
	collisions = value
	
