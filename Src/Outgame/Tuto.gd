extends Node2D

onready var girl_white 			= 	preload("res://Src/Ingame/characters/Girl_white.tscn")
onready var girl_black 			= 	preload("res://Src/Ingame/characters/Girl_black.tscn")
onready var boy_white 			= 	preload("res://Src/Ingame/characters/Boy_white.tscn")
onready var zombie 				= 	preload("res://Src/Ingame/characters/Zombie.tscn")
onready var punk 				= 	preload("res://Src/Ingame/characters/Punk.tscn")
onready var robot 				= 	preload("res://Src/Ingame/characters/Robot.tscn")

onready var monster 		= 	preload("res://Src/Ingame/characters/monsters.tscn")
onready var gold			= 	preload("res://Src/Ingame/characters/gold.tscn")
onready var damage			= 	preload("res://Src/Ingame/characters/Damage.tscn")
onready var health			= 	preload("res://Src/Ingame/characters/Health.tscn")
onready var spawn_fire 		= 	preload("res://Src/Ingame/FX/Fire.tscn")
onready var eye 			= 	preload("res://Src/Ingame/characters/eye.tscn")
onready var controller      =	preload("res://Src/Outgame/Touch_controller.tscn")
var hud 			= 	preload("res://Assets/Textures/hud/hud_hero.tscn")
var score			= 	preload("res://Assets/Textures/hud/hud_score.tscn")
onready var platform		= 	preload("res://Src/Ingame/characters/Moving_platform.tscn")
onready var min_metric_edit = get_node("CanvasLayer/MinMetrics")
onready var max_metric_edit = get_node("CanvasLayer/MaxMetrics")

var damage_comp : Component = null
var hud_show = false
var hud_open  : Component = null
var health_comp_hero : Component = null
var treasure_comp : Component = null
var heroNode : Node2D = null
var Hud_heroNode : Node2D = null
var ScoreNode : Node2D = null
var move_comp : Component = null
var gravity_comp : Component = null
var pos_comp : Component = null
var input : Component = null
var zoom_min : Vector2 = Vector2(0,0)
var zoom_max : Vector2 = Vector2(0,0)
var is_dragging : bool = false
var origin_zoom_ratio : float = 0

func _process(delta):
	tumble()
	if delta > 1:
		update_dragging()

	if hud_show and hud_open != null:
		if hud_open.get_shop() or hud_open.get_stats():
			$CanvasLayer/arrow_life.hide()
			$CanvasLayer/arrow_dmg.hide()
			$CanvasLayer/arrow_shop.hide()
			$CanvasLayer/arrow_stats.hide()
			$CanvasLayer/shop.hide()
			hud_open.set_shop(false)
			hud_open.set_stats(false)

	if treasure_comp != null and damage_comp != null :
		if damage_comp.get_damage() == 0: 
			hud_open.set_hide_health(true)
		if damage_comp.get_damage() > 0:
			hud_open.set_hide_health(false)

func _ready():

	ECS.register_system(SystemsLibrary.Hud)
	ECS.register_system(SystemsLibrary.Move)
	ECS.register_system(SystemsLibrary.Input)
	ECS.register_system(SystemsLibrary.Animation)
	ECS.register_system(SystemsLibrary.Patrol)
	ECS.register_system(SystemsLibrary.Collision)
	ECS.register_system(SystemsLibrary.Bullet)
	ECS.register_system(SystemsLibrary.Missile)

	FileBankUtils.portal = true

	var skin_hero = Scene_transition_data.get_data("skin_hero")
	if skin_hero == 0:
		heroNode = punk.instance()
	elif skin_hero == 1:
		heroNode = girl_white.instance()
	elif skin_hero == 2:
		heroNode = boy_white.instance()
	elif skin_hero == 3:
		heroNode = zombie.instance()
	elif skin_hero == 4:
		heroNode = girl_black.instance()
	elif skin_hero == 5:
		heroNode = robot.instance()
	else:
		heroNode = punk.instance()

	add_child(heroNode)
	CameraUtils.set_camera_root(heroNode)
	CameraUtils.set_offset(Vector2(250, 50))
	CameraUtils.set_zoom(1.5)

	input = ECS.add_component(heroNode, ComponentsLibrary.InputListener) as InputListenerComponent
	var controllerNode = controller.instance()
	add_child(controllerNode)
	controllerNode.set_controller(input, heroNode)

	health_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Health, TagsLibrary.Tag_Hero) as HealthComponent
	var move_comp = ECS.add_component(heroNode, ComponentsLibrary.Movement) as MovementComponent
	move_comp.set_lateral_velocity(300)
	ECS.add_component(heroNode, ComponentsLibrary.Velocity)
	ECS.add_component(heroNode, ComponentsLibrary.Collision)
	pos_comp = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp.set_position(Vector2(8750,500))#(100,400))
	var gravity_comp = ECS.add_component(heroNode, ComponentsLibrary.Gravity) as GravityComponent
	gravity_comp.set_gravity(20)
	gravity_comp.set_gravity(20)
	move_comp.set_jump_impulse(800)
	var comp_anim_hero = ECS.add_component(heroNode, ComponentsLibrary.Animation) as AnimationComponent
	var anim_name_hero = {comp_anim_hero.anim.left : "anim_left", comp_anim_hero.anim.right : "anim_right", 
						  comp_anim_hero.anim.jump : "anim_jump", comp_anim_hero.anim.idle : "anim_idle",
						  comp_anim_hero.anim.colliding : "anim_colliding"}
	var animation_player_hero = heroNode.get_node("AnimationPlayer")
	comp_anim_hero.init(anim_name_hero, animation_player_hero)

	load_platform()
	
#	var anim = AnimationUtils.canvas_fade_in(self)
#	yield(anim, "animation_finished")
#	var anim_rect = AnimationUtils.rect_fade_in(self)
#	yield(anim_rect, "animation_finished")

#	var portalNode = portal.instance()
#	add_child(portalNode)
#	portalNode.set_position(Vector2(29600,1000))

func _on_Move_body_entered(body):
#	$First_Spawn/Move/Control_move.show()
	$First_Spawn/Move/Zoom/Control/anim_left_zoom.play("zoom")
	$First_Spawn/Move/Zoom/Control/anim_right_zoom.play("zoom")
	$First_Spawn/Move/Zoom/Control/anim_right_dezoom.play("dezoom")
	$First_Spawn/Move/Zoom/Control/anim_left_dezoom.play("dezoom")

func _on_Jump_body_entered(body):
	$First_Spawn/Jump/Label3.show()

func _on_Monster_body_entered(body):
	$First_Spawn/Monster/Control_monster.show()
	$First_Spawn/Monster/Monster_spawn.show()
	$First_Spawn/Monster/Control_monster/RichTextLabel.add_font_override("mono_font",  load("res://font/Montserrat-Regular.ttf"))

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

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.doubleclick:
		input.set_is_jumping(true)
	if event is InputEventMouseButton and event.button_index == BUTTON_WHEEL_UP :
		CameraUtils.set_zoom(CameraUtils.get_zoom() - 0.05)
	if event is InputEventMouseButton and event.button_index == BUTTON_WHEEL_DOWN :
		CameraUtils.set_zoom(CameraUtils.get_zoom() + 0.05)

func tumble():
	if pos_comp.get_position().y > 1550:
		Fade.checkpoint(heroNode, Vector2(22000,1300))

# Return the distance between two opposite corner of the touches' bounding box
# (i.e. the distance between the two touches).
func get_touched_area_metrics(box : Rect2) -> float:
	return sqrt(box.size.x * box.size.x + box.size.y * box.size.y)

func update_dragging():
	var min_metrics = float(min_metric_edit.text)
	var max_metrics = float(max_metric_edit.text)

	if TouchUtils.has_bounding_box() and max_metrics > min_metrics:
		if not is_dragging:
			is_dragging = true
			origin_zoom_ratio = CameraUtils.get_zoom_ratio()
		var box = TouchUtils.get_bounding_box()
		var metrics_delta = get_touched_area_metrics(box) - get_touched_area_metrics(TouchUtils.get_origin_bouding_box())
		if abs(metrics_delta) < min_metrics:
			metrics_delta = min_metrics
		var ratio_delta = (metrics_delta - min_metrics) / (max_metrics - min_metrics)
		CameraUtils.set_zoom_ratio(origin_zoom_ratio - ratio_delta)
	else:
		is_dragging = false

func load_platform():
	EntitiesUtils.create_platform(self, platform, Vector2(25250,1250), Vector2(26110,1250),  5)
	EntitiesUtils.create_platform(self, platform, Vector2(27270,1250), Vector2(28080,1250),  5) 

func _on_Hud_body_entered(body):
#	$Hud.disconnect()
	hud_show = true
	$Hud.queue_free()
	$CanvasLayer/Animation_shop.play("up")
	$CanvasLayer/Animation_stats.play("up")
	$CanvasLayer/arrow_life.show()
	$CanvasLayer/arrow_dmg.show()
	$CanvasLayer/arrow_shop.show()
	$CanvasLayer/arrow_stats.show()
	$CanvasLayer/shop.show()
	Hud_heroNode = hud.instance()
	add_child(Hud_heroNode)
	hud_open = ECS.add_component(heroNode, ComponentsLibrary.Is_Open) as IsOpenComponent
	print( " tuto : ", hud_open)
	var ScoreNode = score.instance()
	add_child(ScoreNode)
	ScoreNode.set_hero_node(heroNode, hud_open)

	var hero_health = FileBankUtils.health_max
#	health_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Health, TagsLibrary.Tag_Hero) as HealthComponent
	health_comp_hero.init(hero_health,hero_health)
	health_comp_hero.set_health(health_comp_hero.get_health_max())
	FileBankUtils.health = hero_health


	treasure_comp = ECS.add_component(heroNode, ComponentsLibrary.Treasure, TagsLibrary.Tag_Hero) as TreasureComponent
	treasure_comp.init(FileBankUtils.treasure)


	damage_comp = ECS.add_component(heroNode, ComponentsLibrary.Damage, TagsLibrary.Tag_Hero) as DamageComponent
	damage_comp.init(FileBankUtils.damage, 0)

	var score_comp = ECS.add_component(heroNode, ComponentsLibrary.Scoreglobal, TagsLibrary.Tag_Hero) as ScoreglobalcounterComponent
	score_comp.init_score(FileBankUtils.good_answer, FileBankUtils.wrong_answer, FileBankUtils.victories)
	score_comp.init_stats(FileBankUtils.good_answer, FileBankUtils.wrong_answer, FileBankUtils.victories, FileBankUtils.defeats)

	var hud_comp_hero_fight = ECS.add_component(heroNode, ComponentsLibrary.Hud_fight) as HudFightComponent

	hud_comp_hero_fight.init_hero(Hud_heroNode.get_life_hero(),Hud_heroNode.get_life_hero_label(),
						   Hud_heroNode.get_damage(), hero_health, hero_health)

	var hud_comp_hero_map = ECS.add_component(heroNode, ComponentsLibrary.Hud_map) as HudMapComponent
	hud_comp_hero_map.init_hero(ScoreNode.get_treasure(), treasure_comp.get_treasure(),
								ScoreNode.get_score(), score_comp.compute_score())

	var hud_comp_hero_treasure = ECS.add_component(heroNode, ComponentsLibrary.Hud_treasure) as HudTreasureComponent
	hud_comp_hero_treasure.init_treasure(ScoreNode.get_treasure(), treasure_comp.get_treasure())

