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
				if $HUD/Hotbar.get_active_slot_item()['properties']['item_type'] == Items.ItemType.RANGED_WEAPON:
					$HUD/Hotbar.get_active_slot_item()['uses'] = 6


func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if $HUD/Hotbar.get_active_slot_item()['properties']['item_type'] == Items.ItemType.TOOL:
				var tile_pos = farm.position_to_tile_position(get_global_mouse_position())
				var player_tile_pos = farm.position_to_tile_position(global_position)
				
				# Sets tile based on placement range
				if is_within_tile_reach(tile_pos, player_tile_pos):
					# Foreground Interactions
					if $HUD/Hotbar.get_active_slot_item()['item_id'] == Items.AXE:
						if farm.get_all_tiles_at_tile_position(tile_pos)[farm.FOREGROUND] == 0:
							farm.set_tile_at_position(get_global_mouse_position(), -1, farm.FOREGROUND)
							$HUD/Hotbar.add_item(Items.LOG)
					
					# Background Interactions
					if $HUD/Hotbar.get_active_slot_item()['item_id'] == Items.SHOVEL:
						if farm.get_all_tiles_at_tile_position(tile_pos)[farm.BACKGROUND] == 0:
							if use_stamina(1):
								farm.set_tile_at_position(get_global_mouse_position(), 1, farm.BACKGROUND)
						elif farm.get_all_tiles_at_tile_position(tile_pos)[farm.BACKGROUND] == 1:
							if use_stamina(1):
								farm.set_tile_at_position(get_global_mouse_position(), 2, farm.BACKGROUND)
					elif $HUD/Hotbar.get_active_slot_item()['item_id'] == Items.AXE:
						if farm.get_all_tiles_at_tile_position(tile_pos)[farm.BACKGROUND] == 2:
							if use_stamina(1):
								farm.set_tile_at_position(get_global_mouse_position(), 1, farm.BACKGROUND)
					elif $HUD/Hotbar.get_active_slot_item()['item_id'] == Items.WATER_CAN:
						if farm.get_all_tiles_at_tile_position(tile_pos)[farm.BACKGROUND] == 2:
							if use_stamina(1):
								farm.place_shine(tile_pos)
			elif $HUD/Hotbar.get_active_slot_item()['properties']['item_type'] == Items.ItemType.BLOCK:
				var tile_pos = farm.position_to_tile_position(get_global_mouse_position())
				var player_tile_pos = farm.position_to_tile_position(global_position)
				
				# Sets tile based on placement range
				if is_within_tile_reach(tile_pos, player_tile_pos):
					var block = $HUD/Hotbar.get_active_slot_item()
					
					# Foreground Interactions
					if farm.get_all_tiles_at_tile_position(tile_pos)[farm.FOREGROUND] == -1:
						farm.set_tile_at_position(get_global_mouse_position(), farm.find_tile_id_by_name(block['properties']['name']), farm.FOREGROUND)
						$HUD/Hotbar.remove_item(block['item_id'])
			elif $HUD/Hotbar.get_active_slot_item()['properties']['item_type'] == Items.ItemType.CROP:
				var tile_pos = farm.position_to_tile_position(get_global_mouse_position())
				var player_tile_pos = farm.position_to_tile_position(global_position)
				
				# Sets tile based on placement range
				if is_within_tile_reach(tile_pos, player_tile_pos):
					# Foreground Interactions
					if $HUD/Hotbar.get_active_slot_item()['item_id'] == Items.CORN_SEEDS:
						if farm.get_all_tiles_at_tile_position(tile_pos)[farm.BACKGROUND] == 2:
							farm.place_crop(tile_pos, "Corn")
							$HUD/Hotbar.remove_item(Items.CORN_SEEDS)
			elif $HUD/Hotbar.get_active_slot_item()['properties']['item_type'] == Items.ItemType.RANGED_WEAPON:
				if $HUD/Hotbar.get_active_slot_item()['uses'] > 0:
					$HUD/Hotbar.get_active_slot_item()['uses'] = $HUD/Hotbar.get_active_slot_item()['uses'] - 1
					print($HUD/Hotbar.get_active_slot_item()['uses'])
					
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
	
	if velocity.y > 0:
		$AnimationPlayer.play("move_down")
	elif velocity.y < 0:
		$AnimationPlayer.play("move_up")
	elif velocity.x > 0:
		$AnimationPlayer.play("move_horizontal")
		$Sprite.flip_h = true
	elif velocity.x < 0:
		$AnimationPlayer.play("move_horizontal")
		$Sprite.flip_h = false
	else:
		if last_velocity.y > 0:
			$AnimationPlayer.play("idle_down")
		elif last_velocity.y < 0:
			$AnimationPlayer.play("idle_up")
		elif last_velocity.x > 0:
			$Sprite.flip_h = true
			$AnimationPlayer.play("idle_horizontal")
		elif last_velocity.x < 0:
			$Sprite.flip_h = false
			$AnimationPlayer.play("idle_horizontal")
	
	if last_velocity != velocity:
		last_velocity = velocity


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


func _on_BulletTraceTimer_timeout():
	$BulletTrace.clear_points()
