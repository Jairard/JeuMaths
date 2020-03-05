extends Node

func create_monster(root : Node2D, resource : Resource, pos : Vector2, gold : Resource, health : Resource, damage : Resource):
	var monsterNode = resource.instance()
	root.add_child(monsterNode)

	var comp_position_monster = ECS.add_component(monsterNode, ComponentsLibrary.Position) as PositionComponent
	comp_position_monster.set_position(pos)
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


func create_bullet(root : Node2D, resource : Resource, pos : Vector2):
	var FireNode = resource.instance()
	root.add_child(FireNode)
	
	ECS.add_component(FireNode, ComponentsLibrary.Collision)
	var fire_pos_comp = ECS.add_component(FireNode, ComponentsLibrary.Position) as PositionComponent
	fire_pos_comp.set_position(pos)
	var bullet_position = ECS.add_component(FireNode, ComponentsLibrary.Bullet)
	bullet_position.set_position(pos)


func create_missile(root : Node2D, resource : Resource, pos : Vector2, target : Node2D):
	var EyeNode = resource.instance()
	root.add_child(EyeNode)
	
	var eye_pos_comp = ECS.add_component(EyeNode, ComponentsLibrary.Position) as PositionComponent
	eye_pos_comp.set_position(pos)
	var comp_missile = ECS.add_component(EyeNode, ComponentsLibrary.Nodegetid) as NodegetidComponent
	comp_missile.init(target)
	var comp_rotation = ECS.add_component(EyeNode, ComponentsLibrary.Rotation) as RotationComponent
	comp_rotation.set_rotation(true)







