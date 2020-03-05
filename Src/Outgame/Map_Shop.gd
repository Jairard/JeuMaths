extends Node2D

onready var treasure_damage	= 	preload("res://Src/Ingame/characters/gold.tscn")
onready var treasure_health	= 	preload("res://Src/Ingame/characters/gold.tscn")
onready var treasure_life	= 	preload("res://Src/Ingame/characters/gold.tscn")
onready var hero 			= 	preload("res://Src/Ingame/characters/hero.tscn")
onready var shop			= 	preload("res://Assets/Textures/hud/hud_shop.tscn")
onready var hud_hero		= 	preload("res://Assets/Textures/hud/hud_hero.tscn")

var heroNode : Node2D = null
var health_comp_hero : Component = null
var damage_comp_hero : Component = null
var treasure_comp_hero : Component = null

func _ready():
	ECS.register_system(SystemsLibrary.Hud)
	
	heroNode = hero.instance()
	heroNode.deactivate()
	add_child(heroNode)
	health_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Health, TagsLibrary.Tag_Hero) as HealthComponent
	health_comp_hero.init(FileBankUtils.health,FileBankUtils.health_max)
	damage_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Damage, TagsLibrary.Tag_Hero) as DamageComponent
	treasure_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Treasure, TagsLibrary.Tag_Hero) as TreasureComponent

	var ShopNode = shop.instance()
	add_child(ShopNode)
	var canvas = ShopNode.get_node("CanvasLayer") as CanvasLayer
	canvas.set_offset(Vector2(600,100))
	
	var HudHeroNode = hud_hero.instance()
	add_child(HudHeroNode)
	HudHeroNode.set_position(Vector2(200,200))
	
	var treasureNode_damage = treasure_damage.instance()
	add_child(treasureNode_damage)
	treasureNode_damage.apply_scale(Vector2(1.8,1.8))

	var treasure_damage_pos_comp = ECS.add_component(treasureNode_damage, ComponentsLibrary.Position) as PositionComponent
	treasure_damage_pos_comp.set_position(Vector2(85,418))

	var treasureNode_health = treasure_health.instance()
	add_child(treasureNode_health)
	treasureNode_health.apply_scale(Vector2(1.8,1.8))

	var treasure_health_pos_comp = ECS.add_component(treasureNode_health, ComponentsLibrary.Position) as PositionComponent
	treasure_health_pos_comp.set_position(Vector2(455,418))

	var treasureNode_life = treasure_life.instance()
	add_child(treasureNode_life)
	treasureNode_life.apply_scale(Vector2(1.8,1.8))

	var treasure_life_pos_comp = ECS.add_component(treasureNode_life, ComponentsLibrary.Position) as PositionComponent
	treasure_life_pos_comp.set_position(Vector2(810,418))
	
	var hud_comp = ECS.add_component(heroNode, ComponentsLibrary.Hud) as HudComponent
	hud_comp.init_hero_treasure(ShopNode.get_treasure())
	hud_comp.init_hero_map(HudHeroNode.get_life_hero(),HudHeroNode.get_life_hero_label(),
	HudHeroNode.get_life_hero_max(), HudHeroNode.get_damage())
	
	ECS.clear_ghosts()
	
func _on_Damages_pressed():

	if treasure_comp_hero.get_treasure() >= 10:
		damage_comp_hero.set_damage(damage_comp_hero.get_damage() + 10)
		FileBankUtils.damage += 10
		treasure_comp_hero.set_treasure(treasure_comp_hero.get_treasure() - 10)
		FileBankUtils.treasure = 10
		Scene_changer.change_scene(FileBankUtils.loaded_scenes["playing_map"][1]["map_fire"])


func _on_Health_pressed():
	
	if treasure_comp_hero.get_treasure() >= 10:
		treasure_comp_hero.set_treasure(treasure_comp_hero.get_treasure() - 10)
		FileBankUtils.treasure -= 10
		
		if health_comp_hero.is_health_max():
			health_comp_hero.set_health_max(health_comp_hero.get_health_max() + 10)
			FileBankUtils.health_max += 10
			
		health_comp_hero.set_health(health_comp_hero.get_health() + 10)
		FileBankUtils.health += 10

		Scene_changer.change_scene(FileBankUtils.loaded_scenes["playing_map"][1]["map_fire"])		

func _on_regen_health_pressed():
	
	if treasure_comp_hero.get_treasure() >= 20 and !health_comp_hero.is_health_max():
		health_comp_hero.set_health(FileBankUtils.health_max)
		treasure_comp_hero.set_treasure(treasure_comp_hero.get_treasure() - 20)
		Scene_changer.change_scene(FileBankUtils.loaded_scenes["playing_map"][1]["map_fire"])


	
	
	
