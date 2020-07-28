extends Node2D

onready var hero   			= preload("res://Src/Ingame/characters/Punk.tscn")
onready var heroNode = hero.instance()
onready var enemy 			= preload("res://Src/Ingame/characters/Ennemy.tscn")
onready var enemyNode = enemy.instance()

onready var time_label = get_node("time_label")
onready var game_timer = get_node("game_timer")

var move_comp : Component = null
var pos_comp : Component = null

var direction : Vector2 = Vector2(0,0)
var speed : int = 200
var velocity : Vector2 = speed * direction

var input : Component = null

func set_controller(_input : Component, node : Node2D):
	input = _input

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		input.set_move(true)
		move_comp.set_target(get_global_mouse_position())

func _ready():

	ECS.register_system(SystemsLibrary.Input)
	ECS.register_system(SystemsLibrary.Move)
	ECS.register_system(SystemsLibrary.Collision)

	add_child(heroNode)
	var sprite = $hero/Sprite
	sprite.apply_scale(Vector2(0.5, 0.5))
	$hero/CollisionShape2D2.scale = Vector2(0.5, 0.5)
	heroNode.set_position(Vector2(480,480))
	CameraUtils.set_on_current_camera($Node2D)
	CameraUtils.set_camera_root($Node2D)
	CameraUtils.set_offset(Vector2(600, 400))
	CameraUtils.set_zoom(2.5)
	
	add_child(enemyNode)
	enemyNode.set_position(Vector2(1700,900))
	
#	ECS.register_system(SystemsLibrary.Grid)
	input = ECS.add_component(heroNode, ComponentsLibrary.InputListener) as InputListenerComponent
#	ECS.register_system(SystemsLibrary.Animation)
	ECS.register_system(SystemsLibrary.Collision)
	ECS.register_system(SystemsLibrary.Hud)

	ECS.add_component(heroNode, ComponentsLibrary.Velocity)
	move_comp = ECS.add_component(heroNode, ComponentsLibrary.Movement)
	move_comp.set_lateral_velocity(300)

	var gravity_comp = ECS.add_component(heroNode, ComponentsLibrary.Gravity) as GravityComponent
	gravity_comp.set_gravity(0)

	ECS.add_component(heroNode, ComponentsLibrary.Bounce)
	pos_comp = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp.set_position(Vector2(400,500))



func _process(delta):
	time_label.set_text(str(int(game_timer.get_time_left())))


func _on_game_timer_timeout():
	time_label.hide()
