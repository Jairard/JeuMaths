extends Node2D

onready var treasure_damage	= 	preload("res://Src/Ingame/characters/gold.tscn")
onready var treasure_health	= 	preload("res://Src/Ingame/characters/gold.tscn")
onready var treasure_life	= 	preload("res://Src/Ingame/characters/gold.tscn")
onready var hero 			= 	preload("res://Src/Ingame/characters/hero.tscn")

var heroNode : Node2D = null
var health_comp_hero : Component = null
var damage_comp_hero : Component = null
var treasure_comp_hero : Component = null

func _ready():
	heroNode = hero.instance()
	heroNode.deactivate()
	add_child(heroNode)
	health_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Health, TagsLibrary.Tag_Hero) as HealthComponent
	damage_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Damage, TagsLibrary.Tag_Hero) as DamageComponent
	treasure_comp_hero = ECS.add_component(heroNode, ComponentsLibrary.Treasure, TagsLibrary.Tag_Hero) as TreasureComponent

	var treasureNode_damage = treasure_damage.instance()
	add_child(treasureNode_damage)
	treasureNode_damage.apply_scale(Vector2(1.8,1.8))

	var treasure_damage_pos_comp = ECS.add_component(treasureNode_damage, ComponentsLibrary.Position) as PositionComponent
	treasure_damage_pos_comp.set_position(Vector2(85,218))

	var treasureNode_health = treasure_health.instance()
	add_child(treasureNode_health)
	treasureNode_health.apply_scale(Vector2(1.8,1.8))

	var treasure_health_pos_comp = ECS.add_component(treasureNode_health, ComponentsLibrary.Position) as PositionComponent
	treasure_health_pos_comp.set_position(Vector2(455,218))

	var treasureNode_life = treasure_life.instance()
	add_child(treasureNode_life)
	treasureNode_life.apply_scale(Vector2(1.8,1.8))

	var treasure_life_pos_comp = ECS.add_component(treasureNode_life, ComponentsLibrary.Position) as PositionComponent
	treasure_life_pos_comp.set_position(Vector2(810,218))
#	treasureNode_life.
	
	ECS.clear_ghosts()
	
func _on_Damages_pressed():

	damage_comp_hero.set_damage(damage_comp_hero.get_damage() + 10)
	treasure_comp_hero.set_treasure(treasure_comp_hero.get_treasure() - 10)
	get_tree().change_scene("res://Src/Outgame/Stats.tscn")


func _on_Health_pressed():
	
	health_comp_hero.set_health(health_comp_hero.get_health() + 10)
	treasure_comp_hero.set_treasure(treasure_comp_hero.get_treasure() - 10)
	get_tree().change_scene("res://Src/Outgame/Stats.tscn")

func _on_regen_health_pressed():
	
	health_comp_hero.set_health(FileBankUtils.health_max)
	treasure_comp_hero.set_treasure(treasure_comp_hero.get_treasure() - 20)
	get_tree().change_scene("res://Src/Outgame/Stats.tscn")

	
	
	
