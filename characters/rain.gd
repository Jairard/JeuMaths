extends RigidBody2D

signal loot(valeur)

enum type_rain  {
	health_bonus = 0
	health_malus = 1
	coin = 2
	}
	
export (type_rain) var rain_type

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("loot", get_parent().get_node("hero"), "recup_loot")

func _process(delta):
	if self.position.y >= 540 :
		queue_free()

func start(pos, type):
	self.position = pos
	rain_type = type
	if rain_type == 0 :
		$Area2D/Sprite.modulate = Color (0,0,1)
	if rain_type == 1 :
		$Area2D/Sprite.modulate = Color (1,0,0)
	if rain_type == 2 :
		$Area2D/Sprite.modulate = Color (255,215,0)

func _on_Area2D_body_entered(body):
	self.emit_signal("loot", rain_type)
	queue_free()
