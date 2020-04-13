extends Node2D

var health_comp_hero : Component = null
var damage_comp_hero : Component = null
var treasure_comp_hero : Component = null

var is_shown : bool = false
var prev_hud_pause_mode = Node.PAUSE_MODE_PROCESS

func init(heroNode : Node2D) -> void:
	is_shown = true
	show()
	get_tree().paused = true
	prev_hud_pause_mode = ECS.set_system_pause_mode(SystemsLibrary.Hud, Node.PAUSE_MODE_PROCESS)

	health_comp_hero = ECS.__get_component(heroNode.get_instance_id(), ComponentsLibrary.Health) as HealthComponent

	damage_comp_hero = ECS.__get_component(heroNode.get_instance_id(), ComponentsLibrary.Damage) as DamageComponent
	
	treasure_comp_hero = ECS.__get_component(heroNode.get_instance_id(), ComponentsLibrary.Treasure) as TreasureComponent

#	var anim = AnimationUtils.canvas_fade_in(self)
#	yield(anim, "animation_finished")
#	AnimationUtils.canvas_fade_in(self)
#	var anim_rect = AnimationUtils.rect_fade_in(self)
#	yield(anim_rect, "animation_finished")
#	AnimationUtils.rect_fade_in(self)
#	$Back.show()
#	$anim_back.play("fade_in")


func _on_Damage_pressed():
	if treasure_comp_hero.get_treasure() >= 50:
		damage_comp_hero.set_damage(damage_comp_hero.get_damage() + 5)
		FileBankUtils.damage += 5
		treasure_comp_hero.set_treasure(treasure_comp_hero.get_treasure() - 50)
		FileBankUtils.treasure -= 50 


func _on_Refill_pressed():
	if treasure_comp_hero.get_treasure() >= 10 and !health_comp_hero.is_health_max():
		health_comp_hero.set_health(FileBankUtils.health_max)
		treasure_comp_hero.set_treasure(treasure_comp_hero.get_treasure() - 10)

func _on_Health_pressed():
	if treasure_comp_hero.get_treasure() >= 50:
		treasure_comp_hero.set_treasure(treasure_comp_hero.get_treasure() - 50)
		FileBankUtils.treasure -= 50

		if health_comp_hero.is_health_max():
			health_comp_hero.set_health_max(health_comp_hero.get_health_max() + 10)
			FileBankUtils.health_max += 10

		health_comp_hero.set_health(health_comp_hero.get_health() + 10)
		FileBankUtils.health += 10

func shutdown():
	is_shown = false
	ECS.set_system_pause_mode(SystemsLibrary.Hud, prev_hud_pause_mode)
	hide()
	get_tree().paused = false

func is_shown() -> bool:
	return is_shown 
