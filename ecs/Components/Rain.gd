extends Component

class_name RainComponent

enum type_rain  {
	health_bonus = 0
	health_malus = 1
	coin = 2
	}

#export (type_rain) var rain_type
#
#func start(pos, type):
#	self.position = pos
#	rain_type = type
#	if rain_type == 0 :
#		$Sprite.modulate = Color (0,0,1)
#	if rain_type == 1 :
#		$Sprite.modulate = Color (1,0,0)
#	if rain_type == 2 :
#		$Sprite.modulate = Color (255,215,0)
func unique(_lenght : int) -> Array:		
	var lenght = _lenght
	var unique = []
	
	for x in lenght-1 :
		unique.append([])
		if randi() % 2 == 1 :
			unique[x].append(1)
		else :
			unique[x].append(0)	
	return unique	
		
#func spawn_on_line(_lenght : int, node : Node2D) -> Node2D:
#	var screen_size = get_viewport().size
#	var screen_tile = Vector2(screen_size.x, screen_size.y) / Vector2(64,64)
#
#	var lenght = _lenght
#	var unique = []
#
#	for x in lenght-1 :
#		unique.append([])
#		if randi() % 2 == 1 :
#			unique[x].append(1)
#		else :
#			unique[x].append(0)	
#
#	for x in lenght :
#		if unique[x] == [1] :
#			var x_pos = x
#			var i = node.instance()
#			i.start(Vector2(x_pos * 64 , 0), randi() % 3)
##			add_child(i)
#			return i	
#		else :
#			return null