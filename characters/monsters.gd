extends Area2D

onready var right_move = true
onready var left_move = false

func _ready():
	self.position.x = 725
	self.position.y =  425
	GLOBAL.connect("treasure", self, "death_monster")	
	pass 

func _process(delta):
	
	if right_move == true :
		move_right()
	if left_move == true : 
		move_left()	


func move_right():
	if self.position.x <= 1000 :	
		self.position.x += 1
		$AnimationPlayer.play("anim_monster_right")
	else : 
		right_move = false
		left_move = true		
	

func move_left():
	if self.position.x >= 0 :	
		self.position.x -= 1
	else : 
		left_move = false 
		right_move = true


func _on_Area2D_body_entered(body):
	GLOBAL.pv_hero -= 10
	GLOBAL.emit_signal("pv_hero",GLOBAL.pv_hero)
	queue_free()

func death_monster():
	queue_free()
	

