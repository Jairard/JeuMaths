extends Node2D

onready var hero 			= 	preload("res://Src/Ingame/characters/hero.tscn")
onready var monster 		= 	preload("res://Src/Ingame/characters/monsters.tscn")
onready var gold			= 	preload("res://Src/Ingame/characters/gold.tscn")
onready var damage			= 	preload("res://Src/Ingame/characters/Damage.tscn")
onready var health			= 	preload("res://Src/Ingame/characters/Health.tscn")
onready var spawn_fire 		= 	preload("res://Src/Ingame/FX/Fire.tscn")
onready var eye 			= 	preload("res://Src/Ingame/characters/eye.tscn")

var heroNode : Node2D = null
var move_comp : Component = null
var gravity_comp : Component = null
var pos_comp : Component = null

func _process(delta):
	print ("pos :", pos_comp.get_position())
func _ready():
	ECS.register_system(SystemsLibrary.Move)
	ECS.register_system(SystemsLibrary.Input)
	ECS.register_system(SystemsLibrary.Animation)
	ECS.register_system(SystemsLibrary.Patrol)
	ECS.register_system(SystemsLibrary.Collision)
	ECS.register_system(SystemsLibrary.Bullet)
	ECS.register_system(SystemsLibrary.Missile)

	heroNode = hero.instance()
	add_child(heroNode)
	
	ECS.add_component(heroNode, ComponentsLibrary.InputListener)
	var move_comp = ECS.add_component(heroNode, ComponentsLibrary.Movement) as MovementComponent
	move_comp.set_lateral_velocity(300)
	ECS.add_component(heroNode, ComponentsLibrary.Velocity)
	ECS.add_component(heroNode, ComponentsLibrary.Collision)
	pos_comp = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp.set_position(Vector2(17000,500))
	var gravity_comp = ECS.add_component(heroNode, ComponentsLibrary.Gravity) as GravityComponent
	gravity_comp.set_gravity(20)
	gravity_comp.set_gravity(20)
	move_comp.set_jump_impulse(560)
	
func _on_Move_body_entered(body):
	$Control_move.show()


func _on_Jump_body_entered(body):
	$jump.show()

func _on_Monster_body_entered(body):
	$Control_monster.show()
	$Monster_spawn.show()

func _on_Monster_spawn_body_entered(body):
	EntitiesUtils.create_monster(self, monster, Vector2(3500, 550), gold, health, damage)
	

func _on_Monster_2_body_entered(body):
	EntitiesUtils.create_monster(self, monster, Vector2(5300, 1190), gold, health, damage)

func _on_Monster_3_body_entered(body):
	EntitiesUtils.create_monster(self, monster, Vector2(7650, 225), gold, health, damage)

func _on_Monster_4_body_entered(body):
	EntitiesUtils.create_monster(self, monster, Vector2(12450, 356), gold, health, damage)	
	
func _on_Monster_5_body_entered(body):
	EntitiesUtils.create_monster(self, monster, Vector2(14600, 356), gold, health, damage)
	
func _on_Bullet_body_entered(body):
	$Control_bullet.show()
	$Bullet_spawn.show()

func _on_Bullet_spawn_body_entered(body):
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(10300,490))
	
func _on_Bullet_2_body_entered(body):
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(14200,500))
	
func _on_Missile_body_entered(body):
	$Control_missile.show()
	$Missile_spawn.show()

func _on_Missile_spawn_body_entered(body):
	EntitiesUtils.create_missile(self, eye, Vector2(12100,100), heroNode)
	
func _on_Missile_2_body_entered(body):
	EntitiesUtils.create_missile(self, eye, Vector2(17000,100), heroNode)
	
func _on_Missile_3_body_entered(body):
	EntitiesUtils.create_missile(self, eye, Vector2(18000,150), heroNode)

func _on_Missile_4_body_entered(body):
	EntitiesUtils.create_missile(self, eye, Vector2(19000,150), heroNode)
	pass # Replace with function body.
	
func _on_Return_pressed():
	get_tree().change_scene(FileBankUtils.loaded_scenes["playing_map"][1]["map_fire"])








