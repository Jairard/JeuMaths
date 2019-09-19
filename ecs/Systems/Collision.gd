extends System

class_name CollisionSystem

# There must be a cleaner way to do this
const hero_layer_bit 		: int = 0
const wall_layer_bit 		: int = 1
const enemy_layer_bit 		: int = 2
const spell_layer_bit 		: int = 3
const coin_layer_bit 		: int = 4
const loot_layer_bit 		: int = 5
const monster_layer_bit 	: int = 6
const missile_layer_bit 	: int = 7
const fire_layer_bit 		: int = 8
const gold_layer_bit 		: int = 9
const answer_layer_bit 		: int = 10

onready var treasure = preload("res://characters/treasure.tscn")

func _get_used_components() -> Array:
	return [ComponentsLibrary.Collision, ComponentsLibrary.Position, ComponentsLibrary.Health]

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

func _process_node(dt : float, components : Dictionary) -> void:
	var col_comp = components[ComponentsLibrary.Collision] as CollisionComponent
	var pos_comp = components[ComponentsLibrary.Position] as PositionComponent
	var health_comp = components[ComponentsLibrary.Health] as HealthComponent
	
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
			
		if ((collider != null)                                          		# MONSTER       
		    and (my_body.get_collision_layer_bit(hero_layer_bit) == true)      
			and (collider.get_collision_layer_bit(monster_layer_bit) == true)):  

			print("Monster collision !")
			collider.queue_free()
			health_comp.set_health(health_comp.get_health() - 10)
			
			
		if ((collider != null)                                                 	# SPELL
		    and (my_body.get_collision_layer_bit(hero_layer_bit) == true)      
			and (collider.get_collision_layer_bit(spell_layer_bit) == true)):  

			print("Spell collision !")
			collider.queue_free()
			
		if ((collider != null)                                                 	# COIN
		    and (my_body.get_collision_layer_bit(hero_layer_bit) == true)      
			and (collider.get_collision_layer_bit(coin_layer_bit) == true)):  

			print("Rain collision !")
			collider.queue_free()

		if ((collider != null)                                                 	# LOOT
		    and (my_body.get_collision_layer_bit(hero_layer_bit) == true)      
			and (collider.get_collision_layer_bit(loot_layer_bit) == true)):  

			print("Loot collision !")
			collider.queue_free()

		if ((collider != null)                                                 	# MISSILE
		    and (my_body.get_collision_layer_bit(hero_layer_bit) == true)      
			and (collider.get_collision_layer_bit(missile_layer_bit) == true)):  
	
			print("Missile collision !")
			collider.queue_free()
			health_comp.set_health(health_comp.get_health() - 10)
			
		if ((collider != null)                                                 	# FIRE
		    and (my_body.get_collision_layer_bit(hero_layer_bit) == true)      
			and (collider.get_collision_layer_bit(fire_layer_bit) == true)):  

			print("Fire collision !")
			collider.queue_free()
			health_comp.set_health(health_comp.get_health() - 10)
			
		if ((collider != null)                                                 	# GOLD
		    and (my_body.get_collision_layer_bit(hero_layer_bit) == true)      
			and (collider.get_collision_layer_bit(gold_layer_bit) == true)):  

			print("Gold collision !")
			collider.queue_free()
			
		if ((collider != null)                                                 	# ANSWER
		    and (my_body.get_collision_layer_bit(hero_layer_bit) == true)      
			and (collider.get_collision_layer_bit(answer_layer_bit) == true)):  

			print("Answer collision !")
			collider.queue_free()
			
		if (has_collision_layer(collider,wall_layer_bit) == true 
			and my_body.get_collision_layer_bit(answer_layer_bit) == true): 
				print ("Bounce !")
				
#		if ((collider != null)                                                 	# Bounce answer / wall
#		    and (my_body.get_collision_layer_bit(answer_layer_bit) == true)      
#			and (collider.get_collision_layer_bit(wall_layer_bit) == true)):  
#
#			print("BOUNCE !")
#			#use bounce_collision system
#			collider.queue_free()
