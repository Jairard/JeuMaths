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

var health_comp_hero : Component = null
var pos_comp : Component = null
var heroNode = null

export var color_game = Color("#00000000")
export var color_tumble = Color("#000000")

var file = File.new()
var dict = {}
	
func _ready():
	ECS.register_system(SystemsLibrary.Move)
	ECS.register_system(SystemsLibrary.Input)
	ECS.register_system(SystemsLibrary.Animation)
	ECS.register_system(SystemsLibrary.Collision)
	ECS.register_system(SystemsLibrary.Patrol)
	ECS.register_system(SystemsLibrary.Missile)
	ECS.register_system(SystemsLibrary.Hud)
	ECS.register_system(SystemsLibrary.Bullet)
	ECS.register_system(SystemsLibrary.Bounce)

	load_characters()
	var anim = AnimationUtils.scene_fade_out(self)
	yield(anim, "animation_finished")
	var tween = AnimationUtils.canvas_fade_out(self)
	yield(tween, "tween_completed")
	_load_ressources()
	_load_monsters()
	




	
	ECS.clear_ghosts()

func load_characters() :

	var enemyNode = enemy.instance()
	add_child(enemyNode)


	heroNode = hero.instance()
	add_child(heroNode)


	var HudNode = hud.instance()
	add_child(HudNode)
	HudNode.set_name("Hud")

	var ScoreNode = score.instance()
	add_child(ScoreNode)
	ScoreNode.set_name("Score")


	var enemy_pos_comp = ECS.add_component(enemyNode, ComponentsLibrary.Position) as PositionComponent
	enemy_pos_comp.set_position(Vector2(500,300))														


	ECS.add_component(heroNode, ComponentsLibrary.InputListener)
	ECS.add_component(heroNode, ComponentsLibrary.Bounce)


	pos_comp = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp.set_position(Vector2(300,500))
	ECS.add_component(heroNode, ComponentsLibrary.Collision)
	ECS.add_component(heroNode, ComponentsLibrary.Velocity)
	var gravity_comp = ECS.add_component(heroNode, ComponentsLibrary.Gravity) as GravityComponent
	gravity_comp.set_gravity(20)
	var move_comp = ECS.add_component(heroNode, ComponentsLibrary.Movement) as MovementComponent
	move_comp.set_jump_impulse(800)
	move_comp.set_lateral_velocity(300)
	var comp_anim_hero = ECS.add_component(heroNode, ComponentsLibrary.Animation) as AnimationComponent
	var anim_name_hero = {comp_anim_hero.anim.left : "anim_left", comp_anim_hero.anim.right : "anim_right", 
						  comp_anim_hero.anim.jump : "anim_jump", comp_anim_hero.anim.idle : "anim_idle",
						  comp_anim_hero.anim.colliding : "anim_colliding"}
	var animation_player_hero = heroNode.get_node("animation_hero")
	comp_anim_hero.init(anim_name_hero, animation_player_hero)


	var hud_comp = ECS.add_component(heroNode, ComponentsLibrary.Hud) as HudComponent

	hud_comp.init_hero_map(HudNode.get_life_hero(),HudNode.get_life_hero_label(),
	HudNode.get_life_hero_max(), HudNode.get_damage())

	hud_comp.init_hero_fight(ScoreNode.get_treasure(), ScoreNode.get_score())


	health_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Health, TagsLibrary.Tag_Hero) as HealthComponent
	health_comp_hero.init(FileBankUtils.health_max,FileBankUtils.health_max)
	# Refill the health
	FileBankUtils.health = health_comp_hero.get_health_max()
	health_comp_hero.set_health(FileBankUtils.health)

	var treasure_comp = ECS.add_component(heroNode, ComponentsLibrary.Treasure, TagsLibrary.Tag_Hero) as TreasureComponent
	treasure_comp.init(FileBankUtils.treasure)


	var damage_comp = ECS.add_component(heroNode, ComponentsLibrary.Damage, TagsLibrary.Tag_Hero) as DamageComponent
	damage_comp.init(FileBankUtils.damage)

	var score_comp = ECS.add_component(heroNode, ComponentsLibrary.Scoreglobal, TagsLibrary.Tag_Hero) as ScoreglobalcounterComponent
	score_comp.init_score(FileBankUtils.good_answer, FileBankUtils.wrong_answer, FileBankUtils.victories)
	score_comp.init_stats(FileBankUtils.good_answer, FileBankUtils.wrong_answer, FileBankUtils.victories, FileBankUtils.defeats)	

func combat(valeur) :
	if valeur == 0 :
		Scene_changer.change_scene(FileBankUtils.loaded_scenes["playing_map"][1]["map_fire"])



func _on_Button_pressed():
	save_ressources()
	Scene_changer.change_scene("res://Src/Outgame/Multiscenes.tscn")



func _load_ressources():

#	file.open("res://log_in/pseudo.json", File.READ)
#	dict = parse_json(file.get_as_text())
#	GLOBAL.pv_hero_max = dict["health_max"]
#	GLOBAL.pv_hero = dict["health"]
#	file.close()
	pass
func save_ressources():
#	file.open("res://log_in/pseudo.json", File.WRITE)
#	var dict = to_json(dict)
#	file.store_string(dict)
#	file.close()
	pass
func _on_Timer_timeout():
	_load_bullets()

func _process(delta):
	if health_comp_hero.get_health() <= 0:
		if pos_comp.get_position().x <= 11500:
#			Scene_changer.change_scene(FileBankUtils.loaded_scenes["death"])
			pass
		if pos_comp.get_position().x >11500 and pos_comp.get_position().x <= 20000:
#			tween(Vector2(11500, 500))
#			health_comp_hero.set_health(health_comp_hero.get_health_max())		
			pass	
		if pos_comp.get_position().x >20000:
			AnimationUtils.checkpoint(self, heroNode, pos_comp.get_position(), Vector2(20000,500))
			health_comp_hero.set_health(health_comp_hero.get_health_max())
			
		$ColorRect.hide()
		$CanvasModulate.hide()	


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
