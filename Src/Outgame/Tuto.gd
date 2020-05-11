extends Node2D

onready var hero 			= 	preload("res://Src/Ingame/characters/hero.tscn")
onready var monster 		= 	preload("res://Src/Ingame/characters/monsters.tscn")
onready var gold			= 	preload("res://Src/Ingame/characters/gold.tscn")
onready var damage			= 	preload("res://Src/Ingame/characters/Damage.tscn")
onready var health			= 	preload("res://Src/Ingame/characters/Health.tscn")
onready var spawn_fire 		= 	preload("res://Src/Ingame/FX/Fire.tscn")
onready var eye 			= 	preload("res://Src/Ingame/characters/eye.tscn")
onready var portal 			= 	preload("res://Src/Ingame/FX/smoke_blue.tscn")

var heroNode : Node2D = null
var move_comp : Component = null
var gravity_comp : Component = null
var pos_comp : Component = null

func _process(delta):
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
	pos_comp.set_position(Vector2(100,400))
	var gravity_comp = ECS.add_component(heroNode, ComponentsLibrary.Gravity) as GravityComponent
	gravity_comp.set_gravity(20)
	gravity_comp.set_gravity(20)
	move_comp.set_jump_impulse(800)
	var comp_anim_hero = ECS.add_component(heroNode, ComponentsLibrary.Animation) as AnimationComponent
	var anim_name_hero = {comp_anim_hero.anim.left : "anim_left", comp_anim_hero.anim.right : "anim_right", 
						  comp_anim_hero.anim.jump : "anim_jump", comp_anim_hero.anim.idle : "anim_idle",
						  comp_anim_hero.anim.colliding : "anim_colliding"}
	var animation_player_hero = heroNode.get_node("animation_hero")
	comp_anim_hero.init(anim_name_hero, animation_player_hero)

#	var anim = AnimationUtils.canvas_fade_in(self)
#	yield(anim, "animation_finished")
#	var anim_rect = AnimationUtils.rect_fade_in(self)
#	yield(anim_rect, "animation_finished")

	var portalNode = portal.instance()
	add_child(portalNode)
	portalNode.set_position(Vector2(29600,1000))

func _on_Move_body_entered(body):
	$First_Spawn/Move/Control_move.show()

func _on_Jump_body_entered(body):
	$First_Spawn/Jump/Label3.show()

func _on_Monster_body_entered(body):
	$First_Spawn/Monster/Control_monster.show()
	$First_Spawn/Monster/Monster_spawn.show()
#	$First_Spawn/Monster/Control_monster/RichTextLabel.add_font_override("mono_font",  load("res://font/Montserrat-Regular.ttf"))

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
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(14200,520))

func _on_Missile_body_entered(body):
	$First_Spawn/Missile/Control_missile.show()
	$First_Spawn/Missile/Missile_spawn.show()

func _on_Missile_spawn_body_entered(body):
	EntitiesUtils.create_missile(self, eye, Vector2(12200,200), heroNode)

func _on_Missile_2_body_entered(body):
	EntitiesUtils.create_missile(self, eye, Vector2(17000,100), heroNode)

func _on_Missile_3_body_entered(body):
	EntitiesUtils.create_missile(self, eye, Vector2(18000,150), heroNode)

func _on_Missile_4_body_entered(body):
	EntitiesUtils.create_missile(self, eye, Vector2(19000,150), heroNode)

func _on_Return_pressed():
	Fade.change_scene(FileBankUtils.loaded_scenes["playing_map"][1]["map_fire"])

func tumble():
	if pos_comp.get_position().y > 1550:
		Fade.checkpoint(heroNode, Vector2(22000,1300))
		






