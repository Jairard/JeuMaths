extends Component

class_name PatrolComponent

var x_min = 0
var x_max = 0

onready var right_move = true
onready var left_move = false

func init(value_min : int, value_max : int) -> void : 
	x_min = value_min
	x_max = value_max
		
		
func pattern(value : bool) -> void :
	if right_move == true :
		move_right()
	if left_move == true : 
		move_left()	
		
func move_right():
	if self.position.x <= x_max :	
		self.position.x += 1
	else : 
		right_move = false
		left_move = true		
	

func move_left():
	if self.position.x >= x_min :	
		self.position.x -= 1
	else : 
		left_move = false 
		right_move = true