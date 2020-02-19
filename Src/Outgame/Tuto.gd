extends Node2D

onready var hero 			= 	preload("res://Src/Ingame/characters/hero.tscn")
var heroNode : Node2D = null
var move_comp : Component = null
var gravity_comp : Component = null

func _ready():
	ECS.register_system(SystemsLibrary.Move)
	ECS.register_system(SystemsLibrary.Input)
	ECS.register_system(SystemsLibrary.Animation)

	var heroNode = hero.instance()
	add_child(heroNode)
	
	ECS.add_component(heroNode, ComponentsLibrary.InputListener)
	var move_comp = ECS.add_component(heroNode, ComponentsLibrary.Movement) as MovementComponent
	move_comp.set_lateral_velocity(300)
	ECS.add_component(heroNode, ComponentsLibrary.Velocity)
	var pos_comp = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp.set_position(Vector2(100,530))
	gravity_comp = ECS.add_component(heroNode, ComponentsLibrary.Gravity) as GravityComponent
	gravity_comp.set_gravity(20)
	
func _on_Move_body_entered(body):
	
	print("move")


	print("jump")
	
#	gravity_comp.set_gravity(20)
#	move_comp.set_jump_impulse(650)




func _on_Button_pressed():
	get_tree().change_scene(FileBankUtils.loaded_scenes["playing_map"]["map_fire"])
