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

func _get_used_components() -> Array:
	return [ComponentsLibrary.Collision, ComponentsLibrary.Position, ComponentsLibrary.Health, 
			ComponentsLibrary.Bounce, ComponentsLibrary.Loot]

func _get_system_dependencies() -> Array:
	return [SystemsLibrary.Move]

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
		var colliderId = colliderNode.get_instance_id()
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
	var col_comp 	= 	components[ComponentsLibrary.Collision] as 	CollisionComponent
	var pos_comp	= 	components[ComponentsLibrary.Position] 	as 	PositionComponent
	var health_comp = 	components[ComponentsLibrary.Health] 	as 	HealthComponent
	var bounce_comp	= 	components[ComponentsLibrary.Bounce] 	as  BounceComponent  

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

	# Give the information to the collision component.
	# If the node is not a kinematic body, the collisions are reset to an empty array


	#instance_from_id
	for col in collisions:
		var collider = col.get_collider() 		
		
		
		if (has_collision_layer(collider,enemy_layer_bit) == true 
			and my_body.get_collision_layer_bit(hero_layer_bit) == true):    	# ENEMY
			print("Enemy collision !") 
			collider.queue_free()
			
		if (has_collision_layer(collider,monster_layer_bit) == true 
			and my_body.get_collision_layer_bit(hero_layer_bit) == true):  		# MONSTER

			print("Monster collision !")
			if spawn_loot(collider as Node2D) == false:
				health_comp.set_health(health_comp.get_health() - 10)	
				collider.queue_free()
			
			
		if (has_collision_layer(collider,spell_layer_bit) == true 
			and my_body.get_collision_layer_bit(hero_layer_bit) == true):  		 # SPELL

			print("Spell collision !")
			collider.queue_free()
			
		if (has_collision_layer(collider,rain_layer_bit) == true 
			and my_body.get_collision_layer_bit(hero_layer_bit) == true):		# RAIN

			print("Rain collision !")
			collider.queue_free()

		if (has_collision_layer(collider,xp_layer_bit) == true 
			and my_body.get_collision_layer_bit(hero_layer_bit) == true):  		# XP

			print("Xp collision !")
			collider.queue_free()

		if (has_collision_layer(collider,missile_layer_bit) == true 
			and my_body.get_collision_layer_bit(hero_layer_bit) == true):  		# MISSILE
	
			print("Missile collision !")
			collider.queue_free()
			health_comp.set_health(health_comp.get_health() - 10)
			
		if (has_collision_layer(collider,fire_layer_bit) == true 
			and my_body.get_collision_layer_bit(hero_layer_bit) == true):		# FIRE

			print("Fire collision !")
			collider.queue_free()
			health_comp.set_health(health_comp.get_health() - 10)
			
		if (has_collision_layer(collider,gold_layer_bit) == true 
			and my_body.get_collision_layer_bit(hero_layer_bit) == true):  		# GOLD

			print("Gold collision !")
			collider.queue_free()
		
		if (has_collision_layer(collider,damage_layer_bit) == true 
			and my_body.get_collision_layer_bit(hero_layer_bit) == true):  		# DAMAGE

			print("Damage collision !")
			collider.queue_free()
		
		if (has_collision_layer(collider,health_layer_bit) == true 
			and my_body.get_collision_layer_bit(hero_layer_bit) == true):  		# HEALTH

			print("Health collision !")
			collider.queue_free()
			
		if (has_collision_layer(collider,answer_layer_bit) == true 				# ANSWER
			and my_body.get_collision_layer_bit(hero_layer_bit) == true): 

			print("Answer collision !")
			collider.queue_free()
			
		if (has_collision_layer(collider,wall_layer_bit) == true 				# Bounce answer / wall
			and my_body.get_collision_layer_bit(answer_layer_bit) == true): 
				
			print ("Bounce !")
			bounce_comp.set_is_bouncing(true)
#			var test = collider.get_normal()
#			MoveUtils.vector_orthogonal(test)
		
