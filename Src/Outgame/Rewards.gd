extends Node2D

onready var hero 			= 	preload("res://Src/Ingame/characters/hero.tscn")
onready var loot 			= 	preload("res://Src/Ingame/characters/Null.tscn")
onready var hud 			= 	preload("res://Assets/Textures/hud/hud_hero.tscn")

onready var gold			= 	preload("res://Src/Ingame/characters/gold.tscn")
onready var damage			= 	preload("res://Src/Ingame/characters/Damage.tscn")
onready var health			= 	preload("res://Src/Ingame/characters/Health.tscn")

onready var score			= 	preload("res://Assets/Textures/hud/hud_score.tscn")
onready var controller      =	preload("res://Src/Outgame/Touch_controller.tscn")
onready var fps_label = get_node("CanvasLayer/Label") 
onready var min_metric_edit = get_node("CanvasLayer/MinMetrics")
onready var max_metric_edit = get_node("CanvasLayer/MaxMetrics")

var health_comp_hero : Component = null

var input : Component = null
var zoom_min : Vector2 = Vector2(0,0)
var zoom_max : Vector2 = Vector2(0,0)
var is_dragging : bool = false
var origin_zoom_ratio : float = 0

func _process(delta):
	if delta > 1:
		update_dragging()

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.doubleclick:
		input.set_is_jumping((true)
	if event is InputEventMouseButton and event.button_index == BUTTON_WHEEL_UP :
		CameraUtils.set_zoom(CameraUtils.get_zoom() - 0.05)
		print("zoom : ", CameraUtils.get_zoom())
	if event is InputEventMouseButton and event.button_index == BUTTON_WHEEL_DOWN :
		CameraUtils.set_zoom(CameraUtils.get_zoom() + 0.05)
		print("zoom : ", CameraUtils.get_zoom())
		
func _ready():

	ECS.register_system(SystemsLibrary.Move)
	ECS.register_system(SystemsLibrary.Input)
	ECS.register_system(SystemsLibrary.Animation)
	ECS.register_system(SystemsLibrary.Collision)
	ECS.register_system(SystemsLibrary.Hud)


	var heroNode = hero.instance()
	add_child(heroNode)
	CameraUtils.set_camera_from_hero(heroNode)
	CameraUtils.set_offset(Vector2(250, 50))
	CameraUtils.set_zoom(1.5)

	input = ECS.add_component(heroNode, ComponentsLibrary.InputListener) as InputListenerComponent
	var controllerNode = controller.instance()
	add_child(controllerNode)
	controllerNode.set_controller(input, heroNode)
	ECS.add_component(heroNode, ComponentsLibrary.Loot)

	var hero_health = FileBankUtils.health_max
	health_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Health, TagsLibrary.Tag_Hero) as HealthComponent
	health_comp_hero.init(hero_health,hero_health)
	health_comp_hero.set_health(health_comp_hero.get_health_max())
	FileBankUtils.health = hero_health

	var pos_comp = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp.set_position(Vector2(100,400))
	ECS.add_component(heroNode, ComponentsLibrary.Collision)
	ECS.add_component(heroNode, ComponentsLibrary.Velocity)
	var treasure_comp = ECS.add_component(heroNode, ComponentsLibrary.Treasure, TagsLibrary.Tag_Hero) as TreasureComponent	
	var damage_comp = ECS.add_component(heroNode, ComponentsLibrary.Damage, TagsLibrary.Tag_Hero) as DamageComponent
	var gravity_comp = ECS.add_component(heroNode, ComponentsLibrary.Gravity) as GravityComponent
	gravity_comp.set_gravity(20)
	var move_comp = ECS.add_component(heroNode, ComponentsLibrary.Movement) as MovementComponent
	move_comp.set_lateral_velocity(300)
	var comp_anim_hero = ECS.add_component(heroNode, ComponentsLibrary.Animation) as AnimationComponent
	var anim_name_hero = {comp_anim_hero.anim.left : "anim_left", comp_anim_hero.anim.right : "anim_right", comp_anim_hero.anim.jump : "anim_jump", comp_anim_hero.anim.idle : "anim_idle"}
	var animation_player_hero = heroNode.get_node("animation_hero")
	comp_anim_hero.init(anim_name_hero, animation_player_hero)

	var lootNode = loot.instance()
	add_child(lootNode)
	lootNode.set_name("loot")

	ECS.add_component(lootNode, ComponentsLibrary.Collision)
	var pos_comp_loot = ECS.add_component(lootNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp_loot.set_position(Vector2(100,500))

	var health_comp_loot = ECS.add_component(lootNode, ComponentsLibrary.Health) as HealthComponent
	health_comp_loot.init(1,1)
	var lootdict = [ {gold : 10}, {damage : 5, health : 5, null : 90}]#, damage : 50}]#, null : 90} ]
	var loot_comp = ECS.add_component(lootNode, ComponentsLibrary.Loot) as LootComponent
	loot_comp.init(lootdict, lootNode)

	var HudNode = hud.instance()
	add_child(HudNode)

	var ScoreNode = score.instance()
	add_child(ScoreNode)
	ScoreNode.set_hero_node(heroNode)
	
	var score_comp = ECS.add_component(heroNode, ComponentsLibrary.Scoreglobal, TagsLibrary.Tag_Hero) as ScoreglobalcounterComponent
	score_comp.init_score(FileBankUtils.good_answer, FileBankUtils.wrong_answer, FileBankUtils.victories)
	score_comp.init_stats(FileBankUtils.good_answer, FileBankUtils.wrong_answer, FileBankUtils.victories, FileBankUtils.defeats)
	
	var hud_comp_hero_fight = ECS.add_component(heroNode, ComponentsLibrary.Hud_fight) as HudFightComponent

	hud_comp_hero_fight.init_hero(HudNode.get_life_hero(),HudNode.get_life_hero_label(), 
									HudNode.get_damage(), hero_health, hero_health)

	var hud_comp_hero_map = ECS.add_component(heroNode, ComponentsLibrary.Hud_map) as HudMapComponent
	hud_comp_hero_map.init_hero(ScoreNode.get_treasure(), treasure_comp.get_treasure(), 
								ScoreNode.get_score(), score_comp.compute_score())
								
	var hud_comp_hero_treasure = ECS.add_component(heroNode, ComponentsLibrary.Hud_treasure) as HudTreasureComponent
	hud_comp_hero_treasure.init_treasure(ScoreNode.get_treasure(), treasure_comp.get_treasure())

	ECS.clear_ghosts()

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
