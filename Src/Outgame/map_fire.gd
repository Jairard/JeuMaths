extends Node2D

onready var enemy 			= 	preload("res://Src/Ingame/characters/Ennemy.tscn")
onready var hero 			= 	preload("res://Src/Ingame/characters/hero.tscn")
onready var hud 			= 	preload("res://Assets/Textures/hud/hud_hero.tscn")
onready var rain			= 	preload("res://Src/Ingame/characters/rain.tscn")
onready var eye 			= 	preload("res://Src/Ingame/characters/eye.tscn")
onready var monster 		= 	preload("res://Src/Ingame/characters/monsters.tscn")
onready var spawn_fire 		= 	preload("res://Src/Ingame/FX/Fire.tscn")

onready var gold			= 	preload("res://Src/Ingame/characters/gold.tscn")
onready var damage			= 	preload("res://Src/Ingame/characters/Damage.tscn")
onready var health			= 	preload("res://Src/Ingame/characters/Health.tscn")

onready var score			= 	preload("res://Assets/Textures/hud/hud_score.tscn")

var health_comp_hero : Component = null

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

	_load_ressources()
	load_characters()
	ECS.clear_ghosts()

func spawn_rain():
	RainUtils.spawn_at(2100,2200,20,100,self,rain)

func load_characters() :

	var enemyNode = enemy.instance()
	add_child(enemyNode)
	enemyNode.set_name("enemy")

	var heroNode = hero.instance()
	add_child(heroNode)
	heroNode.set_name("hero")

	var monsterNode = monster.instance()
	add_child(monsterNode)
	monsterNode.set_name("monster")

	var EyeNode = eye.instance()
	add_child(EyeNode)
	EyeNode.set_name("eye")

	var HudNode = hud.instance()
	add_child(HudNode)
	HudNode.set_name("Hud")

	var ScoreNode = score.instance()
	add_child(ScoreNode)
	ScoreNode.set_name("Score")


	var enemy_pos_comp = ECS.add_component(enemyNode, ComponentsLibrary.Position) as PositionComponent
	enemy_pos_comp.set_position(Vector2(3500,300))														#Appears at (0,0)


	ECS.add_component(heroNode, ComponentsLibrary.InputListener)
	ECS.add_component(heroNode, ComponentsLibrary.Bounce)


	var pos_comp = ECS.add_component(heroNode, ComponentsLibrary.Position) as PositionComponent
	pos_comp.set_position(Vector2(100,400))
	ECS.add_component(heroNode, ComponentsLibrary.Collision)
	ECS.add_component(heroNode, ComponentsLibrary.Velocity)
	var gravity_comp = ECS.add_component(heroNode, ComponentsLibrary.Gravity) as GravityComponent
	gravity_comp.set_gravity(20)
	var move_comp = ECS.add_component(heroNode, ComponentsLibrary.Movement) as MovementComponent
	move_comp.set_jump_impulse(650)
	move_comp.set_lateral_velocity(300)
	var comp_anim_hero = ECS.add_component(heroNode, ComponentsLibrary.Animation) as AnimationComponent
	var anim_name_hero = {comp_anim_hero.anim.left : "anim_left", comp_anim_hero.anim.right : "anim_right", 
						  comp_anim_hero.anim.jump : "anim_jump", comp_anim_hero.anim.idle : "anim_idle",
						  comp_anim_hero.anim.colliding : "anim_colliding"}
	var animation_player_hero = heroNode.get_node("animation_hero")
	comp_anim_hero.init(anim_name_hero, animation_player_hero)

	ECS.add_component(monsterNode, ComponentsLibrary.Position)
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

	var eye_pos_comp = ECS.add_component(EyeNode, ComponentsLibrary.Position) as PositionComponent
	eye_pos_comp.set_position(enemy_pos_comp.get_position())
	var comp_missile = ECS.add_component(EyeNode, ComponentsLibrary.Nodegetid) as NodegetidComponent
	comp_missile.init(heroNode)
	var comp_rotation = ECS.add_component(EyeNode, ComponentsLibrary.Rotation) as RotationComponent
	comp_rotation.set_rotation(true)

#	ECS.add_component(FireNode, ComponentsLibrary.Collision)
#	var fire_pos_comp = ECS.add_component(FireNode, ComponentsLibrary.Position) as PositionComponent
#	fire_pos_comp.set_position(Vector2(1000,540))
#	var bullet_position = ECS.add_component(FireNode, ComponentsLibrary.Bullet)
#	bullet_position.set_position(fire_pos_comp.get_position())


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

	var score_comp = ECS.add_component(heroNode, ComponentsLibrary.Scoregolbal, TagsLibrary.Tag_Hero) as ScoreglobalcounterComponent
	score_comp.init(FileBankUtils.good_answer, FileBankUtils.wrong_answer, FileBankUtils.victories)

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
	print ("go")
	EntitiesUtils.create_bullet(self, spawn_fire, Vector2(1000,540))
	

func _on_Area2D_body_entered(body):
	spawn_rain()

func _process(delta):
	if health_comp_hero.get_health() <= 0:
		Scene_changer.change_scene(FileBankUtils.loaded_scenes["death"])
	
