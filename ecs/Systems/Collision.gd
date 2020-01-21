extends System

class_name CollisionSystem

# There must be a cleaner way to do this
const hero_layer_bit 		: int = 0
const wall_layer_bit 		: int = 1
const enemy_layer_bit 		: int = 2
const spell_layer_bit 		: int = 3
const rain_layer_bit 		: int = 4
const xp_layer_bit 			: int = 5
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
			ComponentsLibrary.Loot, ComponentsLibrary.Xp, ComponentsLibrary.Treasure, 
			ComponentsLibrary.Damage, ComponentsLibrary.Velocity, ComponentsLibrary.Stats,
			ComponentsLibrary.AnswertoSpell]

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
	var xp_comp 		= 	components[ComponentsLibrary.Xp] 		as  XpComponent
	var damage_comp 	= 	components[ComponentsLibrary.Damage] 	as 	DamageComponent
	var treasure_comp 	= 	components[ComponentsLibrary.Treasure] 	as 	TreasureComponent  
	var stats_comp	 	= 	components[ComponentsLibrary.Stats] 	as 	CharacterstatsComponent
	var answer_comp 	=   components[ComponentsLibrary.AnswertoSpell] as AnswerListenerComponent
	
	
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
#		print ("collider : ",collider)
		if ArrayUtils.contains(processed_collider,collider):
			continue											#pass to the next iteration
		processed_collider.append(collider)
														
		var collider_ID : int = collider.get_instance_id() 
		var collider_health_component 	: HealthComponent 	= _getComponentOfEntity(collider_ID, ComponentsLibrary.Health)
		var collider_damage_component 	: DamageComponent 	= _getComponentOfEntity(collider_ID, ComponentsLibrary.Damage)
#		var my_body_damage_component 	: AnswertoSpellComponent 	= _getComponentOfEntity(collider_ID, ComponentsLibrary.AnswertoSpell)
		var my_body_damage_component 	: DamageComponent 	= _getComponentOfEntity(my_body.get_instance_id(), ComponentsLibrary.Damage)
		
		if (has_collision_layer(collider,enemy_layer_bit) == true 
			and my_body.get_collision_layer_bit(hero_layer_bit) == true) and (health_comp != null):    			# ENEMY
			print("Enemy collision !") 
#			print ("health hero 1 : ", health_comp.get_health())
			var new_scene = FileBankUtils.loaded_scenes["map_fight_1"]
			var node = health_comp.get_node()
			node.get_tree().change_scene(new_scene)
			collider.queue_free()
			
		if (has_collision_layer(collider,monster_layer_bit) == true 
			and my_body.get_collision_layer_bit(hero_layer_bit) == true) and (health_comp != null):  		# MONSTER

			print("Monster collision !")
			if spawn_loot(collider as Node2D) == false:
				health_comp.set_health(health_comp.get_health() - 10)	
				collider.queue_free()

		if (has_collision_layer(collider,hero_layer_bit) == true 
			and my_body.get_collision_layer_bit(spell_layer_bit) == true) and (collider_health_component != null) and (my_body_damage_component.get_damage() != null):  		 # SPELL from Enemy to Hero

			print("Spell collision to Hero!")
			print ("enemy collision: ",my_body_damage_component.get_damage())
#			collider_health_component.set_health(collider_health_component.get_health() - collider_damage_component.damage)
			collider_health_component.set_health(collider_health_component.get_health() - my_body_damage_component.get_damage())
#			collider_health_component.set_health(collider_health_component.get_health() - my_body_damage_component.get_damage())
			my_body.queue_free()
			
		
		if (has_collision_layer(collider,enemy_layer_bit) == true 
			and my_body.get_collision_layer_bit(spell_layer_bit) == true)  and (collider_health_component != null) and (my_body_damage_component.get_damage() != null):  		 # SPELL from Hero to Enemy

			print("Spell collision to Enemy !")
			print ("hero collision : ", my_body_damage_component.get_damage())
			collider_health_component.set_health(collider_health_component.get_health() - my_body_damage_component.get_damage())
#			collider_health_component.set_health(collider_health_component.get_health() - my_body_damage_component.get_damage())
			my_body.queue_free()
			

		if (has_collision_layer(collider,rain_layer_bit) == true 
			and my_body.get_collision_layer_bit(hero_layer_bit) == true):			# RAIN
#			print (collider.get_path())
			print("Rain collision !")
			collider.call_deferred("free")
#			collider.queue_free()

		if (has_collision_layer(collider,xp_layer_bit) == true 
			and my_body.get_collision_layer_bit(hero_layer_bit) == true) and (xp_comp != null):  		# XP + 10

			xp_comp.set_xp(xp_comp.get_xp() + 110)
			if xp_comp.get_xp() >= 100:
				xp_comp.set_lvl(xp_comp.get_lvl() + 1)
				var new_xp = xp_comp.get_xp() - 100
				xp_comp.set_xp(new_xp)
			collider.queue_free()

		if (has_collision_layer(collider,missile_layer_bit) == true 
			and my_body.get_collision_layer_bit(hero_layer_bit) == true) and (health_comp != null):  		# MISSILE health - 10
			
			print("Missile collision !")
#			print("Missile collision with " + collider.get_path() + " id=" + str(collider.get_instance_id()))
			collider.queue_free()
			health_comp.set_health(health_comp.get_health() - 10)

		if (has_collision_layer(collider,fire_layer_bit) == true 
			and my_body.get_collision_layer_bit(hero_layer_bit) == true) and (health_comp != null):		# FIRE health - 10

			print("Fire collision !")
			collider.queue_free()
			health_comp.set_health(health_comp.get_health() - 10)
#		print ("collider : ", collider)
		if (has_collision_layer(collider,gold_layer_bit) == true 
			and my_body.get_collision_layer_bit(hero_layer_bit) == true):  		# GOLD	treasure + 10

			print("Gold collision !")
			collider.queue_free()
			
			if treasure_comp != null:
				treasure_comp.set_treasure(treasure_comp.get_treasure() + 10)
			

		if (has_collision_layer(collider,damage_layer_bit) == true 
			and my_body.get_collision_layer_bit(hero_layer_bit) == true) and (damage_comp != null):  		# DAMAGE +10

			print("Damage collision !")
			damage_comp.set_damage(damage_comp.get_damage() + 10)
			collider.queue_free()

		if (has_collision_layer(collider,health_layer_bit) == true 
			and my_body.get_collision_layer_bit(hero_layer_bit) == true) and (health_comp != null):  		# HEALTH +10

			print("Health collision !")

			if health_comp.get_health() >= health_comp.get_health_max():
				health_comp.set_health_max(health_comp.get_health_max() + 10)
				health_comp.set_health(health_comp.get_health_max())
			else :
				health_comp.set_health(health_comp.get_health() + 10)
			collider.queue_free()

		if (has_collision_layer(collider,answer_layer_bit) == true 				# ANSWER
			and my_body.get_collision_layer_bit(hero_layer_bit) == true): 

			print("Answer collision !")
			collider.queue_free()

		if (has_collision_layer(collider,wall_layer_bit) == true 				# Bounce answer / wall
			and my_body.get_collision_layer_bit(answer_layer_bit) == true) and (bounce_comp != null): 

			var normal = col.get_normal()
			bounce_comp.set_is_bouncing(normal)
			
		if (has_collision_layer(collider,portal_layer_bit) == true 
			and my_body.get_collision_layer_bit(hero_layer_bit) == true) and (health_comp != null):    			# PORTAL
			
			print("Portal collision !") 
			var new_scene = FileBankUtils.loaded_scenes["map_fire"]
			var node = health_comp.get_node()
#			yield(node.get_parent().get_tree().create_timer(1.0), "timeout")
			node.get_tree().change_scene(new_scene)
			collider.queue_free()
