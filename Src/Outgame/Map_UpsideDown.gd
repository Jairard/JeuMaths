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
	ECS.register_system(SystemsLibrary.UpsideDown)
	ECS.register_system(SystemsLibrary.Input)
	ECS.register_system(SystemsLibrary.Animation)
	ECS.register_system(SystemsLibrary.Collision)
	ECS.register_system(SystemsLibrary.Patrol)
	ECS.register_system(SystemsLibrary.Missile)
	ECS.register_system(SystemsLibrary.Hud)
	ECS.register_system(SystemsLibrary.Bullet)
	ECS.register_system(SystemsLibrary.Bounce)

	load_characters()
#	var anim = AnimationUtils.scene_fade_out(self)
#	yield(anim, "animation_finished")
#	var tween = AnimationUtils.canvas_fade_out(self)
#	yield(tween, "tween_completed")
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
	enemy_pos_comp.set_position(Vector2(-200,500))														

	load_gold()

	ECS.add_component(heroNode, ComponentsLibrary.InputListener)
	ECS.add_component(heroNode, ComponentsLibrary.Bounce)

	heroNode.get_node("hero_spr").set_rotation_degrees(-180)
	heroNode.get_node("hero_spr").set_flip_h(true)
	pos_comp = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp.set_position(Vector2(4500,300))
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
	EntitiesUtils.create_flip_monster(self, monster, Vector2(4750,345), gold, health, damage)
	EntitiesUtils.create_flip_monster(self, monster, Vector2(5590,345), gold, health, damage)
	EntitiesUtils.create_flip_monster(self, monster, Vector2(6405,345), gold, health, damage)
	EntitiesUtils.create_flip_monster(self, monster, Vector2(7250,345), gold, health, damage)
	EntitiesUtils.create_flip_monster(self, monster, Vector2(8060,345), gold, health, damage)
	EntitiesUtils.create_flip_monster(self, monster, Vector2(9480,345), gold, health, damage)
	EntitiesUtils.create_flip_monster(self, monster, Vector2(11750,730), gold, health, damage)
	EntitiesUtils.create_flip_monster(self, monster, Vector2(14370,603), gold, health, damage)
	EntitiesUtils.create_flip_monster(self, monster, Vector2(16145,603), gold, health, damage)
	EntitiesUtils.create_flip_monster(self, monster, Vector2(15245,860), gold, health, damage)



func _load_bullets():
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(18760,100))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(20040,100))
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(21320,100))

func _on_Timer_timeout():
		_load_bullets()

func load_gold():
	EntitiesUtils.create_gold(self, gold, Vector2(1300,50))
	EntitiesUtils.create_gold(self, gold, Vector2(2070,150))
	EntitiesUtils.create_gold(self, gold, Vector2(11325,-50))
	EntitiesUtils.create_gold(self, gold, Vector2(12030,-50))
	EntitiesUtils.create_gold(self, gold, Vector2(12675,-50))
	EntitiesUtils.create_gold(self, gold, Vector2(11900,1050))
	EntitiesUtils.create_gold(self, gold, Vector2(11585,1600))
	EntitiesUtils.create_gold(self, gold, Vector2(12025,-1800))
	EntitiesUtils.create_gold(self, gold, Vector2(12415,1800))
	EntitiesUtils.create_gold(self, gold, Vector2(13175,1250))