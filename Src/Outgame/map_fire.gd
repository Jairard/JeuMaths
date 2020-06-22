extends Node2D

onready var enemy 			= 	preload("res://Src/Ingame/characters/Ennemy.tscn")
onready var hero 			= 	preload("res://Src/Ingame/characters/hero.tscn")
onready var hud 			= 	preload("res://Assets/Textures/hud/hud_hero.tscn")
onready var eye 			= 	preload("res://Src/Ingame/characters/eye.tscn")
onready var monster 		= 	preload("res://Src/Ingame/characters/monsters.tscn")
onready var spawn_fire 		= 	preload("res://Src/Ingame/FX/Fire.tscn")

onready var gold			= 	preload("res://Src/Ingame/characters/gold.tscn")
onready var damage			= 	preload("res://Src/Ingame/characters/Damage.tscn")
onready var health			= 	preload("res://Src/Ingame/characters/Health.tscn")

onready var score			= 	preload("res://Assets/Textures/hud/hud_score.tscn")
onready var platform		= 	preload("res://Src/Ingame/characters/Moving_platform.tscn")

onready var controller      =	preload("res://Src/Outgame/Touch_controller.tscn")
onready var fps_label = get_node("CanvasLayer/Label") 
onready var min_metric_edit = get_node("CanvasLayer/Control/MinMetrics")
onready var max_metric_edit = get_node("CanvasLayer/Control/MaxMetrics")

var health_comp_hero : Component = null
var pos_comp : Component = null
var heroNode = null
var treasure_comp : Component = null
var move_comp : Component = null
var input : Component = null
var zoom_min : Vector2 = Vector2(0,0)
var zoom_max : Vector2 = Vector2(0,0)
var is_dragging : bool = false
var origin_zoom_ratio : float = 0

var file = File.new()
var dict = {}

func _ready():
	
	ECS.register_system(SystemsLibrary.Move)
	ECS.register_system(SystemsLibrary.Input)
#	ECS.register_system(SystemsLibrary.Animation)
	ECS.register_system(SystemsLibrary.Collision)
	ECS.register_system(SystemsLibrary.Patrol)
	ECS.register_system(SystemsLibrary.Missile)
	ECS.register_system(SystemsLibrary.Hud)
	ECS.register_system(SystemsLibrary.Bullet)
	ECS.register_system(SystemsLibrary.Bounce)

	load_characters()
	_load_monsters()
	load_gold()
	load_platform()

	ECS.clear_ghosts()

func load_characters() :

	var enemyNode = enemy.instance()
#	add_child(enemyNode)


	heroNode = hero.instance()
	add_child(heroNode)
	CameraUtils.set_camera_from_hero(heroNode)
	CameraUtils.set_offset(Vector2(250, 50))
	CameraUtils.set_zoom(1.5)

	var Hud_heroNode = hud.instance()
	add_child(Hud_heroNode)

	var hud_open = ECS.add_component(heroNode, ComponentsLibrary.Is_Open)
	var ScoreNode = score.instance()
	add_child(ScoreNode)
	ScoreNode.set_hero_node(heroNode, hud_open)

	input = ECS.add_component(heroNode, ComponentsLibrary.InputListener) as InputListenerComponent
	var controllerNode = controller.instance()
	add_child(controllerNode)
	controllerNode.set_controller(input, heroNode)
	
	ECS.add_component(heroNode, ComponentsLibrary.Bounce)
	pos_comp = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp.set_position(Vector2(400,500))
	ECS.add_component(heroNode, ComponentsLibrary.Collision)
	ECS.add_component(heroNode, ComponentsLibrary.Velocity)
	var gravity_comp = ECS.add_component(heroNode, ComponentsLibrary.Gravity) as GravityComponent
	gravity_comp.set_gravity(20)
	move_comp = ECS.add_component(heroNode, ComponentsLibrary.Movement) as MovementComponent
	move_comp.set_jump_impulse(800)
	move_comp.set_lateral_velocity(300)
	var comp_anim_hero = ECS.add_component(heroNode, ComponentsLibrary.Animation) as AnimationComponent
	var anim_name_hero = {comp_anim_hero.anim.left : "anim_left", comp_anim_hero.anim.right : "anim_right", 
						  comp_anim_hero.anim.jump : "anim_jump", comp_anim_hero.anim.idle : "anim_idle",
						  comp_anim_hero.anim.colliding : "anim_colliding"}
	var animation_player_hero = heroNode.get_node("animation_hero")
	comp_anim_hero.init(anim_name_hero, animation_player_hero)


	var hero_health = FileBankUtils.health_max
	health_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Health, TagsLibrary.Tag_Hero) as HealthComponent
	health_comp_hero.init(hero_health,hero_health)
	health_comp_hero.set_health(health_comp_hero.get_health_max())
	FileBankUtils.health = hero_health


	treasure_comp = ECS.add_component(heroNode, ComponentsLibrary.Treasure, TagsLibrary.Tag_Hero) as TreasureComponent
	treasure_comp.init(FileBankUtils.treasure)


	var damage_comp = ECS.add_component(heroNode, ComponentsLibrary.Damage, TagsLibrary.Tag_Hero) as DamageComponent
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

func _on_Timer_timeout():
	_load_bullets()

func _process(delta):
	fps_label.set_text(str(Engine.get_frames_per_second()))
	if health_comp_hero.get_health() <= 0 :
		if pos_comp.get_position().x <= 11500:
			Fade.checkpoint(heroNode, Vector2(400,500))
		if pos_comp.get_position().x >11500:
			Fade.checkpoint(heroNode, Vector2(11500,500))
		treasure_comp.set_treasure(treasure_comp.get_treasure() *  0.7)
		FileBankUtils.treasure *= 0.7
		health_comp_hero.set_health(health_comp_hero.get_health_max())
	update_dragging()

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.doubleclick:
		input.set_jump(true)
	if event is InputEventMouseButton and event.button_index == BUTTON_WHEEL_UP :
		CameraUtils.set_zoom(CameraUtils.get_zoom() - 0.05)
		print("zoom : ", CameraUtils.get_zoom())
	if event is InputEventMouseButton and event.button_index == BUTTON_WHEEL_DOWN :
		CameraUtils.set_zoom(CameraUtils.get_zoom() + 0.05)
		print("zoom : ", CameraUtils.get_zoom())


func _load_monsters():
	EntitiesUtils.create_monster(self, monster, Vector2(750, 295), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(1500,165), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(2470,295), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(5000,-95), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(14400,40), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(14400,-350), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(14600,-800), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(18500,575), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(18200,125), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(18300,-335), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(18400,-780), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(18400,-1230), gold, health, damage)


func _load_bullets():
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(2060,550))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(4670,550))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(6100,550))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(7430,550))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(13000,800))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(15500,800))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(17000,800))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(21200,800))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(22410,800))
		
	
func _load_missiles():
	EntitiesUtils.create_missile(self, eye, Vector2(23500,0), heroNode)
	EntitiesUtils.create_missile(self, eye, Vector2(29000,0), heroNode)
	EntitiesUtils.create_missile(self, eye, Vector2(33000,0), heroNode)


func _on_Missile_spawn_body_entered(body):
	_load_missiles()

func load_gold():
	EntitiesUtils.create_gold(self, gold, Vector2(2075,4700))
	EntitiesUtils.create_gold(self, gold, Vector2(10500,450))
	EntitiesUtils.create_gold(self, gold, Vector2(10500,0))
	EntitiesUtils.create_gold(self, gold, Vector2(10500,-450))
	EntitiesUtils.create_gold(self, gold, Vector2(6875,-500))
	EntitiesUtils.create_gold(self, gold, Vector2(11300,450))
	EntitiesUtils.create_gold(self, gold, Vector2(3370,250))
	EntitiesUtils.create_gold(self, gold, Vector2(4825,250))
	EntitiesUtils.create_gold(self, gold, Vector2(6235,250))
	EntitiesUtils.create_gold(self, gold, Vector2(7575,250))
	EntitiesUtils.create_gold(self, gold, Vector2(12300,750))
	EntitiesUtils.create_gold(self, gold, Vector2(14750,750))
	EntitiesUtils.create_gold(self, gold, Vector2(16700,750))
	EntitiesUtils.create_gold(self, gold, Vector2(20930,750))

func load_platform():
	EntitiesUtils.create_platform(self, platform, Vector2(12250,550), Vector2(12850,550),  3.5) 

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
