extends Node2D

onready var hero 			= 	preload("res://Src/Ingame/characters/hero.tscn")
onready var monster 		= 	preload("res://Src/Ingame/characters/monsters.tscn")
onready var gold			= 	preload("res://Src/Ingame/characters/gold.tscn")
onready var damage			= 	preload("res://Src/Ingame/characters/Damage.tscn")
onready var health			= 	preload("res://Src/Ingame/characters/Health.tscn")
onready var spawn_fire 		= 	preload("res://Src/Ingame/FX/Fire.tscn")
onready var eye 			= 	preload("res://Src/Ingame/characters/eye.tscn")
onready var portal 			= 	preload("res://Src/Ingame/FX/smoke_2.tscn")

var heroNode : Node2D = null
var move_comp : Component = null
var gravity_comp : Component = null
var pos_comp : Component = null

export var color_game = Color("#00000000")
export var color_tumble = Color("#000000")

func _process(delta):
#	print ("pos :", pos_comp.get_position())
	tumble()
	
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
	
	ECS.add_component(heroNode, ComponentsLibrary.Health)	
	ECS.add_component(heroNode, ComponentsLibrary.InputListener)
	var move_comp = ECS.add_component(heroNode, ComponentsLibrary.Movement) as MovementComponent
	move_comp.set_lateral_velocity(300)
	ECS.add_component(heroNode, ComponentsLibrary.Velocity)
	ECS.add_component(heroNode, ComponentsLibrary.Collision)
	pos_comp = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp.set_position(Vector2(10000,500))
	var gravity_comp = ECS.add_component(heroNode, ComponentsLibrary.Gravity) as GravityComponent
	gravity_comp.set_gravity(20)
	gravity_comp.set_gravity(20)
	move_comp.set_jump_impulse(560)
	var comp_anim_hero = ECS.add_component(heroNode, ComponentsLibrary.Animation) as AnimationComponent
	var anim_name_hero = {comp_anim_hero.anim.left : "anim_left", comp_anim_hero.anim.right : "anim_right", 
						  comp_anim_hero.anim.jump : "anim_jump", comp_anim_hero.anim.idle : "anim_idle",
						  comp_anim_hero.anim.colliding : "anim_colliding"}
	var animation_player_hero = heroNode.get_node("animation_hero")
	comp_anim_hero.init(anim_name_hero, animation_player_hero)
	
	var portalNode = portal.instance()
	add_child(portalNode)
	portalNode.set_position(Vector2(29600,1000))
	
func _on_Move_body_entered(body):
	$First_Spawn/Move/Control_move.show()


func _on_Jump_body_entered(body):
	$First_Spawn/Jump/jump.show()

func _on_Monster_body_entered(body):
	$First_Spawn/Monster/Control_monster.show()
	$First_Spawn/Monster/Monster_spawn.show()

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
	$First_Spawn/Bullet/Control_bullet.show()
	$First_Spawn/Bullet/Bullet_spawn.show()

func _on_Bullet_spawn_body_entered(body):
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(10300,520))
	
func _on_Bullet_2_body_entered(body):
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(14200,500))
	
func _on_Missile_body_entered(body):
	$First_Spawn/Missile/Control_missile.show()
	$First_Spawn/Missile/Missile_spawn.show()

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
	Scene_changer.change_scene(FileBankUtils.loaded_scenes["playing_map"][1]["map_fire"])

func tumble():
	if pos_comp.get_position().y > 1550:
		var tween = Tween.new()
		add_child(tween)
		$CanvasModulate.show()
		tween.interpolate_property($CanvasModulate, "color", color_tumble, color_game, 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		tween.start()
		yield(tween, "tween_completed")
		remove_child(tween)
		
		$Control/ColorRect.show()
		$Control/AnimationPlayer.play("test")
		yield($Control/AnimationPlayer, "animation_finished")

		pos_comp.set_position(Vector2(22000,1300))
		
	else:
		$Control/ColorRect.hide()
		$CanvasModulate.hide()
		
		
		





