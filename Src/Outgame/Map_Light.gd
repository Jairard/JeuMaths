extends Node2D

onready var punk 			= 	preload("res://Src/Ingame/characters/Punk.tscn")
onready var controller      =	preload("res://Src/Outgame/Touch_controller.tscn")
onready var monster 		= 	preload("res://Src/Ingame/characters/monsters.tscn")
onready var gold			= 	preload("res://Src/Ingame/characters/gold.tscn")
onready var damage			= 	preload("res://Src/Ingame/characters/Damage.tscn")
onready var health			= 	preload("res://Src/Ingame/characters/Health.tscn")
onready var light			= 	preload("res://Src/Outgame/Light.tscn")
onready var spawn_fire 		= 	preload("res://Src/Ingame/FX/Fire.tscn")

onready var min_metric_edit = get_node("CanvasLayer/Control/MinMetrics")
onready var max_metric_edit = get_node("CanvasLayer/Control/MaxMetrics")
var zoom_min : Vector2 = Vector2(0,0)
var zoom_max : Vector2 = Vector2(0,0)
var is_dragging : bool = false
var origin_zoom_ratio : float = 0

func _ready():

	ECS.register_system(SystemsLibrary.Move)
	ECS.register_system(SystemsLibrary.Input)
	ECS.register_system(SystemsLibrary.Collision)
	ECS.register_system(SystemsLibrary.Patrol)
	ECS.register_system(SystemsLibrary.Bullet)
	var heroNode = punk.instance()
	add_child(heroNode)
	CameraUtils.set_camera_root(heroNode)
	CameraUtils.set_offset(Vector2(250, 50))
	CameraUtils.set_zoom(1.5)
	var pos_comp = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp.set_position(Vector2(100,500))
	var input = ECS.add_component(heroNode, ComponentsLibrary.InputListener) as InputListenerComponent
	var controllerNode = controller.instance()
	add_child(controllerNode)
	controllerNode.set_controller(input, heroNode)
	ECS.add_component(heroNode, ComponentsLibrary.Collision)
	ECS.add_component(heroNode, ComponentsLibrary.Velocity)
	var gravity_comp = ECS.add_component(heroNode, ComponentsLibrary.Gravity) as GravityComponent
	gravity_comp.set_gravity(20)
	var move_comp = ECS.add_component(heroNode, ComponentsLibrary.Movement) as MovementComponent
	move_comp.set_jump_impulse(800)
	move_comp.set_lateral_velocity(375)

	_load_monsters()
	_load_light()

func _process(delta):
		update_dragging()

func _input(event):
#	if event is InputEventMouseButton and event.is_pressed() and event.doubleclick:
#		input.set_is_jumping(true)
	if event is InputEventMouseButton and event.button_index == BUTTON_WHEEL_UP :
		CameraUtils.set_zoom(CameraUtils.get_zoom() - 0.05)
	if event is InputEventMouseButton and event.button_index == BUTTON_WHEEL_DOWN :
		CameraUtils.set_zoom(CameraUtils.get_zoom() + 0.05)

func _load_monsters():
	EntitiesUtils.create_monster(self, monster, Vector2(1500,360), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(410,100), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(1300,-90), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(2175,860), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(3610,-90), gold, health, damage)
	EntitiesUtils.create_monster(self, monster, Vector2(5150,100), gold, health, damage)

func _load_bullets():
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(4000,600))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(5450,600))

func _load_light():
	EntitiesUtils.create_light(self, light, Vector2(500,200))
	EntitiesUtils.create_light(self, light, Vector2(900,455))
	EntitiesUtils.create_light(self, light, Vector2(2530,-175))
	EntitiesUtils.create_light(self, light, Vector2(2905,-175))
	
	EntitiesUtils.create_light(self, light, Vector2(3615,15))
	EntitiesUtils.create_light(self, light, Vector2(4010,600))
	EntitiesUtils.create_light(self, light, Vector2(5480,600))
	EntitiesUtils.create_light(self, light, Vector2(5410,-180))
	
	EntitiesUtils.create_light(self, light, Vector2(5040,-50))
	EntitiesUtils.create_light(self, light, Vector2(6050,-50))
	EntitiesUtils.create_light(self, light, Vector2(6370,270))
	EntitiesUtils.create_light(self, light, Vector2(7430,420))
	
	
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
		CameraUtils.set_zoom_ratio(origin_zoom_ratio + ratio_delta)
	else:
		is_dragging = false


func _on_Timer_timeout():
	_load_bullets()
