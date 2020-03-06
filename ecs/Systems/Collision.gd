extends System

class_name CollisionSystem

# There must be a cleaner way to do this
const hero_layer_bit 		: int = 0
const wall_layer_bit 		: int = 1
const enemy_layer_bit 		: int = 2
const spell_layer_bit 		: int = 3
const rain_layer_bit 		: int = 4

const monster_layer_bit 	: int = 6
const missile_layer_bit 	: int = 7
const fire_layer_bit 		: int = 8
const gold_layer_bit 		: int = 9
const answer_layer_bit 		: int = 10
const damage_layer_bit 		: int = 11
const health_layer_bit 		: int = 12
const portal_layer_bit 		: int = 13

func _get_mandatory_components() -> Array:
	return [ComponentsLibrary.Collision]

func _get_optional_components() -> Array:
	return [ComponentsLibrary.Position, ComponentsLibrary.Health, ComponentsLibrary.Bounce,
			ComponentsLibrary.Loot, ComponentsLibrary.Treasure, ComponentsLibrary.Damage, ComponentsLibrary.Movement,
			ComponentsLibrary.Velocity, ComponentsLibrary.Stats, ComponentsLibrary.AnswertoSpell]

func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Move, SystemsLibrary.Answer]

func has_collision_layer(collider : Object, layer : int) -> bool:
	var physicBody = collider as PhysicsBody2D
	if (physicBody != null):
		return physicBody.get_collision_layer_bit(layer) == true

	var tileMap = collider as TileMap
	if (tileMap != null):
		return tileMap.get_collision_layer_bit(layer) == true

	return false

func spawn_loot(colliderNode : Node2D) -> bool:
	if colliderNode != null :
		var loot_comp = EcsUtils.get_first_component_in_parent(colliderNode, ComponentsLibrary.Loot, self) as LootComponent
		if loot_comp != null and loot_comp.get_loot_generator() == colliderNode:
			var test_loot 		: Array		= loot_comp.get_loots()
			var dp 				: Vector2 	= Vector2(150,-50)
			var loot_node 		: Node2D 	= loot_comp.get_node()
			var loot_pos 		: Vector2 	= loot_node.get_position()
			var loot_root		: Node2D 	= loot_node.get_parent()
			for x in test_loot:
				loot_root.add_child(x)
				x.set_position(loot_pos + dp)
				dp += Vector2(100,0)
			loot_node.queue_free()
			return true
	return false

func _process_node(dt : float, components : Dictionary) -> void:
	var col_comp 		= 	components[ComponentsLibrary.Collision] as 	CollisionComponent
	var pos_comp		= 	components[ComponentsLibrary.Position] 	as 	PositionComponent
	var health_comp 	= 	components[ComponentsLibrary.Health] 	as 	HealthComponent
	var bounce_comp		= 	components[ComponentsLibrary.Bounce] 	as  BounceComponent
	var damage_comp 	= 	components[ComponentsLibrary.Damage] 	as 	DamageComponent
	var treasure_comp 	= 	components[ComponentsLibrary.Treasure] 	as 	TreasureComponent
	var stats_comp	 	= 	components[ComponentsLibrary.Stats] 	as 	CharacterstatsComponent
	var answer_comp 	=   components[ComponentsLibrary.AnswertoSpell] as AnswerListenerComponent
	var comp_move		= 	components[ComponentsLibrary.Movement] 	as MovementComponent


	# Check if the node is a PhysicsBody2D
	var my_body = col_comp.get_node() as PhysicsBody2D
	if (my_body == null):
		return

	# Collision detection
	var body = pos_comp.get_node() as KinematicBody2D # Try to get the node as a kinematic body
	var collisions : Array = [] # The array in which we'll store the collisions

	if body != null: # If it succeeds, we can proceed
		var collision_count : int = body.get_slide_count() # get the collision count

		for i in range(collision_count):
			var current_collision = body.get_slide_collision(i) # For each collision,
			collisions.append(current_collision)                # we append it to the array

	var processed_collider : Array = []
	for col in collisions:
		var collider = col.get_collider()
		if ArrayUtils.contains(processed_collider,collider):
			continue											#pass to the next iteration
		processed_collider.append(collider)

		var collider_ID : int = collider.get_instance_id()
		var collider_health_component 	: HealthComponent 	= _getComponentOfEntity(collider_ID, ComponentsLibrary.Health)
		var collider_damage_component 	: DamageComponent 	= _getComponentOfEntity(collider_ID, ComponentsLibrary.Damage)
		var my_body_damage_component 	: DamageComponent 	= _getComponentOfEntity(my_body.get_instance_id(), ComponentsLibrary.Damage)
		var my_body_move_component 	: MovementComponent	= _getComponentOfEntity(my_body.get_instance_id(), ComponentsLibrary.Movement)
		

		if (has_collision_layer(collider,enemy_layer_bit) == true
			and my_body.get_collision_layer_bit(hero_layer_bit) == true) :    			# ENEMY

			print("Enemy collision !")

			if health_comp != null:
				var new_scene = FileBankUtils.loaded_scenes["map_fight_1"]
				Scene_changer.change_scene(new_scene)
			collider.queue_free()

		if (has_collision_layer(collider,monster_layer_bit) == true
			and my_body.get_collision_layer_bit(hero_layer_bit) == true) :  		# MONSTER

			print("Monster collision !")
			collider.queue_free()

			if (spawn_loot(collider as Node2D) == false and health_comp != null):			
				health_comp.set_health(health_comp.get_health() - 10)
				FileBankUtils.health -= 10
				TweenAnimationUtils.tween_hero_collision(my_body)			
				
					
				
		if (has_collision_layer(collider,hero_layer_bit) == true
			and my_body.get_collision_layer_bit(spell_layer_bit) == true) :  		 # SPELL from Enemy to Hero

#			print("Spell collision to Hero!")

			if (collider_health_component != null) and (my_body_damage_component.get_damage() != null):
				collider_health_component.set_health(collider_health_component.get_health() - my_body_damage_component.get_damage())
				FileBankUtils.health -= my_body_damage_component.get_damage()
			my_body.queue_free()


		if (has_collision_layer(collider,enemy_layer_bit) == true
			and my_body.get_collision_layer_bit(spell_layer_bit) == true):  		 # SPELL from Hero to Enemy

#			print("Spell collision to Enemy !")

			if (collider_health_component != null and my_body_damage_component.get_damage() != null):
				collider_health_component.set_health(collider_health_component.get_health() - my_body_damage_component.get_damage())
				FileBankUtils.health -= my_body_damage_component.get_damage()
			my_body.queue_free()


		if (has_collision_layer(collider,rain_layer_bit) == true
			and my_body.get_collision_layer_bit(hero_layer_bit) == true):			# RAIN

			print("Rain collision !")
			comp_move.set_direction(comp_move.dir.colliding)			
			FileBankUtils.health -= 5
			collider.call_deferred("free")


		if (has_collision_layer(collider,missile_layer_bit) == true
			and my_body.get_collision_layer_bit(hero_layer_bit) == true): 		# MISSILE health - 10

			print("Missile collision !")
			comp_move.set_direction(comp_move.dir.colliding)
			collider.queue_free()
			
			if health_comp != null:
				health_comp.set_health(health_comp.get_health() - 10)
				FileBankUtils.health -= 10
				TweenAnimationUtils.tween_hero_collision(my_body)

		if (has_collision_layer(collider,wall_layer_bit) == true
			and my_body.get_collision_layer_bit(missile_layer_bit) == true): 		# MISSILE vs wall

			print("Missile destruction")
			my_body.queue_free()

		if (has_collision_layer(collider,fire_layer_bit) == true
			and my_body.get_collision_layer_bit(hero_layer_bit) == true):		# FIRE health - 10

			print("Fire collision !")
			collider.queue_free()
#			my_body_move_component.set_direction(my_body_move_component.dir.colliding)
#			print ("dir : ", my_body_move_component.dir.colliding)
#			yield(my_body_move_component.get_node().get_parent().get_tree().create_timer(10), "timeout")
			
			if health_comp != null:
				health_comp.set_health(health_comp.get_health() - 10)# lerp(0, 10, 0))
				FileBankUtils.health -= 10
				TweenAnimationUtils.tween_hero_collision(my_body)			
		

		if (has_collision_layer(collider,gold_layer_bit) == true
			and my_body.get_collision_layer_bit(hero_layer_bit) == true):  		# GOLD	treasure + 10

			print("Gold collision !")
#			var node = collider.get_node("Sprite")
#			var tween = node.get_node("Tween")
#			tween.interpolate_property(
#			node, "position", node.position,
#			Vector2(node.position.x, node.position.y - 500),
#			1.5, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
#
#			tween.interpolate_property(
#			node, "scale", Vector2(1,1), Vector2(2, 2),
#			1.5, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
#
#			tween.interpolate_property(
#			node, "modulate", Color(1.0,1.0,1.0,1.0), Color(1.0,1.0,1.0,0.0),
#			0.5, Tween.TRANS_BACK, Tween.EASE_IN_OUT,1)
#
#			tween.start()
#			yield(tween, "tween_completed")
			
			TweenAnimationUtils.tween_hero_loot(collider)
			collider.queue_free()

			if treasure_comp != null:
				treasure_comp.set_treasure(treasure_comp.get_treasure() + 10)
				FileBankUtils.treasure += 10
				


		if (has_collision_layer(collider,damage_layer_bit) == true
			and my_body.get_collision_layer_bit(hero_layer_bit) == true):  		# DAMAGE +10

			print("Damage collision !")

			if damage_comp != null:
				damage_comp.set_damage(damage_comp.get_damage() + 10)
				FileBankUtils.damage += 10
				TweenAnimationUtils.tween_hero_loot(collider)
				
			collider.queue_free()

		if (has_collision_layer(collider,health_layer_bit) == true
			and my_body.get_collision_layer_bit(hero_layer_bit) == true):  		# HEALTH +10

			print("Health collision !")

			if health_comp != null:
				if health_comp.get_health() >= health_comp.get_health_max():
					health_comp.set_health_max(health_comp.get_health_max() + 10)
					health_comp.set_health(health_comp.get_health_max())
				else :
					health_comp.set_health(health_comp.get_health() + 10)
				FileBankUtils.health += 10
				TweenAnimationUtils.tween_hero_loot(collider)
				
			collider.queue_free()

		if (has_collision_layer(collider,answer_layer_bit) == true 				# ANSWER
			and my_body.get_collision_layer_bit(hero_layer_bit) == true):

			print("Answer collision !")
			collider.queue_free()

		if (has_collision_layer(collider,wall_layer_bit) == true 				# Bounce answer / wall
			and my_body.get_collision_layer_bit(answer_layer_bit) == true):

			if bounce_comp != null:
				var normal = col.get_normal()
				bounce_comp.set_is_bouncing(normal)

		if (has_collision_layer(collider,portal_layer_bit) == true
			and my_body.get_collision_layer_bit(hero_layer_bit) == true):    			# PORTAL

			print("Portal collision !")

			if health_comp != null:
#				var new_scene = FileBankUtils.loaded_scenes["next_level"]
#				var node = health_comp.get_node()
#				yield(node.get_parent().get_tree().create_timer(1.0), "timeout")
#				node.get_tree().change_scene(new_scene)
				Scene_changer.change_scene(FileBankUtils.loaded_scenes["playing_map"][1]["map_fire"])
			collider.queue_free()
			
