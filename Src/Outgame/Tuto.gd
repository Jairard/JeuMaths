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
	
	var monsterNode = monster.instance()
	add_child(monsterNode)
	
	ECS.add_component(heroNode, ComponentsLibrary.InputListener)
	var move_comp = ECS.add_component(heroNode, ComponentsLibrary.Movement) as MovementComponent
	move_comp.set_lateral_velocity(300)
	ECS.add_component(heroNode, ComponentsLibrary.Velocity)
	ECS.add_component(heroNode, ComponentsLibrary.Collision)
	var pos_comp = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp.set_position(Vector2(100,530))
	var gravity_comp = ECS.add_component(heroNode, ComponentsLibrary.Gravity) as GravityComponent
	gravity_comp.set_gravity(20)
	gravity_comp.set_gravity(20)
	move_comp.set_jump_impulse(500)
	
	var comp_position_monster = ECS.add_component(monsterNode, ComponentsLibrary.Position) as PositionComponent
	comp_position_monster.set_position(Vector2(2100,550))
	var comp_anim_monster = ECS.add_component(monsterNode, ComponentsLibrary.Animation) as AnimationComponent
	var anim_name_monster = {comp_anim_monster.anim.right : "anim_right"}
	var animation_player_monster = monsterNode.get_node("animation_monster")
	comp_anim_monster.init(anim_name_monster, animation_player_monster)
	var comp_patrol = ECS.add_component(monsterNode, ComponentsLibrary.Patrol) as PatrolComponent
	comp_patrol.init(700,900)
	var health_comp_monster = ECS.add_component(monsterNode, ComponentsLibrary.Health) as HealthComponent
	health_comp_monster.init(1,1)
	var lootDict_monster = [ {gold : 10}, {health : 10, damage : 5, null : 90}]
	var loot_comp_monster = ECS.add_component(monsterNode, ComponentsLibrary.Loot) as LootComponent
	loot_comp_monster.init(lootDict_monster, monsterNode.get_node("head"))
	
	
	
func _on_Move_body_entered(body):
	$Control_move.show()


func _on_Jump_body_entered(body):
	$jump.show()
	
func _on_Monster_body_entered(body):
	print("monster")
	$Control_monster.show()

func _on_Bullet_body_entered(body):
	$Control_bullet.show()
	
func _on_Missile_body_entered(body):
	$Control_missile.show()
	
		
func _on_Return_pressed():
	get_tree().change_scene(FileBankUtils.loaded_scenes["playing_map"][1]["map_fire"])


func _on_GO_bullet_pressed():
	var FireNode = spawn_fire.instance()
	add_child(FireNode)
	ECS.add_component(FireNode, ComponentsLibrary.Bullet)
	ECS.add_component(FireNode, ComponentsLibrary.Collision)
	var fire_pos_comp = ECS.add_component(FireNode, ComponentsLibrary.Position) as PositionComponent
	fire_pos_comp.set_position(Vector2(4500,520))


func _on_GO_missile_pressed():
	var EyeNode = eye.instance()
	add_child(EyeNode)
	var eye_pos_comp = ECS.add_component(EyeNode, ComponentsLibrary.Position) as PositionComponent
	eye_pos_comp.set_position(Vector2(5500,300))
	var comp_missile = ECS.add_component(EyeNode, ComponentsLibrary.Nodegetid) as NodegetidComponent
	comp_missile.init(heroNode)
	var comp_rotation = ECS.add_component(EyeNode, ComponentsLibrary.Rotation) as RotationComponent
	comp_rotation.set_rotation(true)





	
