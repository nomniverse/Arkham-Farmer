extends Actor


# Settings
const PLACEMENT_TILE_RANGE = 2

var walk_speed = 200
var run_speed = 400

var farm


# Called when the node enters the scene tree for the first time.
func _ready():
	farm = get_tree().get_root().get_node("Game/Farm")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.is_action_pressed("toggle_light"):
				$Flashlight.enabled = not $Flashlight.enabled
			
			if event.is_action_pressed("reload"):
				if $HUD/Inventory.get_active_slot_item()['properties']['item_type'] == Items.ItemType.RANGED_WEAPON:
					var bullet_slot = $HUD/Inventory.find_item_slot(Items.BULLET)

					if bullet_slot:
						var missing_bullets = $HUD/Inventory.get_active_slot_item()['properties']['capacity'] - $HUD/Inventory.get_active_slot_item()['uses']
						print(missing_bullets)
						if $HUD/Inventory.get_item_at_slot(bullet_slot)['quantity'] >= missing_bullets:
							$HUD/Inventory.get_active_slot_item()['uses'] = $HUD/Inventory.get_active_slot_item()['properties']['capacity']
							$HUD/Inventory.remove_item(Items.BULLET, missing_bullets)
						else:
							$HUD/Inventory.get_active_slot_item()['uses'] += $HUD/Inventory.get_item_at_slot(bullet_slot)['quantity']
							$HUD/Inventory.empty_slot(bullet_slot)


func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if get_active_slot_item_type() == Items.ItemType.TOOL:
				var tile_pos = farm.position_to_tile_position(get_global_mouse_position())
				var player_tile_pos = farm.position_to_tile_position(global_position)
				
				# Sets tile based on placement range
				if is_within_tile_reach(tile_pos, player_tile_pos):
					# Foreground Interactions
					if get_active_slot_item_id() == Items.AXE:
						if farm.get_all_tiles_at_tile_position(tile_pos)[farm.FOREGROUND] == 0:
							farm.set_tile_at_position(get_global_mouse_position(), -1, farm.FOREGROUND)
							$HUD/Inventory.add_item(Items.FENCE)
					
					# Background Interactions
					if get_active_slot_item_id() == Items.HOE:
						var background_tile = farm.get_all_tiles_at_tile_position(tile_pos)[farm.BACKGROUND]
						
						if "GRASS" in farm.background_tiles[background_tile]:
							if use_stamina(1):
								farm.set_tile_at_position(get_global_mouse_position(), farm.background_tiles.find("DIRT"), farm.BACKGROUND)
						elif farm.background_tiles[background_tile] == "DIRT":
							if use_stamina(1):
								farm.set_tile_at_position(get_global_mouse_position(), farm.background_tiles.find("TILLED_SOIL"), farm.BACKGROUND)
					elif get_active_slot_item_id() == Items.AXE:
						if farm.get_all_tiles_at_tile_position(tile_pos)[farm.BACKGROUND] == farm.background_tiles.find("TILLED_SOIL"):
							if use_stamina(1):
								farm.set_tile_at_position(get_global_mouse_position(), farm.background_tiles.find("DIRT"), farm.BACKGROUND)
					elif get_active_slot_item_id() == Items.WATER_CAN:
						if farm.get_all_tiles_at_tile_position(tile_pos)[farm.BACKGROUND] == farm.background_tiles.find("TILLED_SOIL"):
							if use_stamina(1):
								farm.set_tile_at_position(get_global_mouse_position(), farm.background_tiles.find("WATERED_SOIL"), farm.BACKGROUND)
			elif get_active_slot_item_type() == Items.ItemType.CROP:
				var tile_pos = farm.position_to_tile_position(get_global_mouse_position())
				var player_tile_pos = farm.position_to_tile_position(global_position)
				
				# Sets tile based on placement range
				if is_within_tile_reach(tile_pos, player_tile_pos):
					# Foreground Interactions
					if get_active_slot_item_id() == Items.CORN_SEEDS:
						if "SOIL" in farm.background_tiles[farm.get_all_tiles_at_tile_position(tile_pos)[farm.BACKGROUND]]:
							farm.place_crop(tile_pos, "Corn")
							$HUD/Inventory.remove_item(Items.CORN_SEEDS)
			elif get_active_slot_item_type() == Items.ItemType.RANGED_WEAPON:
				if $HUD/Inventory.get_active_slot_item()['uses'] > 0:
					$HUD/Inventory.get_active_slot_item()['uses'] = $HUD/Inventory.get_active_slot_item()['uses'] - 1
					print($HUD/Inventory.get_active_slot_item()['uses'])
					
					$BulletRayCast2D.rotation = get_angle_to(get_global_mouse_position())
					$BulletRayCast2D.enabled = true
					$BulletRayCast2D.force_raycast_update()
					
					var points = PoolVector2Array()
					points.append(Vector2(0, 0))
					
					if $BulletRayCast2D.is_colliding():
						points.append(to_local($BulletRayCast2D.get_collision_point()))
						
						if $BulletRayCast2D.get_collider().has_method("take_damage"):
							$BulletRayCast2D.get_collider().take_damage(50)
					else:
						points.append($BulletRayCast2D.cast_to.rotated(get_angle_to(get_global_mouse_position())))
						
					$BulletTrace.points = points
					$BulletTraceTimer.start()
						
					$BulletRayCast2D.enabled = false
				else:
					print("No ammo...")
		if event.button_index == BUTTON_RIGHT and event.pressed:
			if get_active_slot_item_type() == Items.ItemType.BLOCK:
				var tile_pos = farm.position_to_tile_position(get_global_mouse_position())
				var player_tile_pos = farm.position_to_tile_position(global_position)
				
				# Sets tile based on placement range
				if is_within_tile_reach(tile_pos, player_tile_pos):
					var block = $HUD/Inventory.get_active_slot_item()
					
					# Foreground Interactions
					if farm.get_all_tiles_at_tile_position(tile_pos)[farm.FOREGROUND] == -1:
						farm.set_tile_at_position(get_global_mouse_position(), farm.find_tile_id_by_name(block['properties']['name']), farm.FOREGROUND)
						$HUD/Inventory.remove_item(block['item_id'])
			elif get_active_slot_item_type() == Items.ItemType.CONTAINER:
				var tile_pos = farm.position_to_tile_position(get_global_mouse_position())
				var player_tile_pos = farm.position_to_tile_position(global_position)
				
				# Sets tile based on placement range
				if is_within_tile_reach(tile_pos, player_tile_pos):
					# Foreground Interactions
					print("TODO: Place container")
					$HUD/Inventory.remove_item(get_active_slot_item_id())

# Called every physics tick.
func _physics_process(_delta):
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		
	velocity = velocity.normalized() * walk_speed
	velocity = move_and_slide(velocity)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		
		if collision.collider.name == "Roofs":
			print(collision.collider.get_global_position())
			break

	# Flips sprite if mouse is on the left of player
	# NOTE: does not maintain sprite orientation if mouse exactly at player position
	$Sprite.flip_h = get_global_mouse_position().x < global_position.x

	if last_velocity != velocity:
		last_velocity = velocity
		
	if farm.position_has_roof(global_position):
		farm.hide_roof(global_position)
	else:
		farm.show_roof(global_position)


func is_within_tile_reach(tile_position, player_tile_position):
	return abs(tile_position.x - player_tile_position.x) <= PLACEMENT_TILE_RANGE and abs(tile_position.y - player_tile_position.y) <= PLACEMENT_TILE_RANGE


func is_within_position_reach(mouse_position):
	return abs(global_position.x - mouse_position.x) <= PLACEMENT_TILE_RANGE * 16 and abs(global_position.y - mouse_position.y) <= PLACEMENT_TILE_RANGE * 16


func take_damage(amount):
	.take_damage(amount)
	set_health_bar(health)


func use_stamina(amount):
	var can_act = .use_stamina(amount)
	set_stamina_bar(stamina)
	
	return can_act


func die():
	var _error = get_tree().change_scene("res://gui/menus/TitleScreen.tscn")


func set_health_bar(value):
	$HUD/StatusBars.health_bar.value = value


func set_stamina_bar(value):
	$HUD/StatusBars.stamina_bar.value = value


func set_fear_bar(value):
	$HUD/StatusBars.fear_bar.value = value
	
	
func get_active_slot_item_id():
	return $HUD/Inventory.get_active_slot_item()['item_id']
	

func get_active_slot_item_type():
	return $HUD/Inventory.get_active_slot_item()['properties']['item_type']


func _on_BulletTraceTimer_timeout():
	$BulletTrace.clear_points()
