extends Node2D

onready var hero   			= preload("res://Src/Ingame/characters/hero.tscn")
onready var heroNode = hero.instance()

onready var time_label = get_node("time_label")
onready var game_timer = get_node("game_timer")

var move_comp : Component = null
var pos_comp : Component = null

func _ready():
	add_child(heroNode)
	heroNode.set_position(Vector2(480,480))
	CameraUtils.set_on_current_camera($Grid)
	CameraUtils.set_camera_from_hero($Grid)
	CameraUtils.set_offset(Vector2(0, 0))
	CameraUtils.set_zoom(10)
	
#	ECS.register_system(SystemsLibrary.Grid)
	ECS.register_system(SystemsLibrary.Input)
#	ECS.register_system(SystemsLibrary.Animation)
	ECS.register_system(SystemsLibrary.Collision)
	ECS.register_system(SystemsLibrary.Hud)

	ECS.add_component(heroNode, ComponentsLibrary.Velocity)
	ECS.add_component(heroNode, ComponentsLibrary.InputListener)

	ECS.add_component(heroNode, ComponentsLibrary.Bounce)
	pos_comp = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp.set_position(Vector2(400,500))



func _process(delta):
	time_label.set_text(str(int(game_timer.get_time_left())))


func _on_game_timer_timeout():
	time_label.hide()
