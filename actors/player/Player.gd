extends Actor


# Settings
const PLACEMENT_TILE_RANGE = 2

var walk_speed = 200
var run_speed = 400

var farm

var roof_pos = null
var under_roof = false

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
					if get_active_slot_item_id() == Items.HOE:
						use_hoe(tile_pos)
					elif get_active_slot_item_id() == Items.AXE:
						use_axe(tile_pos)
					elif get_active_slot_item_id() == Items.WATER_CAN:
						use_watering_can(tile_pos)
			elif get_active_slot_item_type() == Items.ItemType.SEED:
				var tile_pos = farm.position_to_tile_position(get_global_mouse_position())
				var player_tile_pos = farm.position_to_tile_position(global_position)
				
				# Sets tile based on placement range
				if is_within_tile_reach(tile_pos, player_tile_pos):
					# Foreground Interactions
					if "SOIL" in farm.background_tiles[farm.get_all_tiles_at_tile_position(tile_pos)[farm.BACKGROUND]]:
						farm.place_crop(tile_pos, get_active_slot_item_id())
						$HUD/Inventory.remove_item(get_active_slot_item_id())
			elif get_active_slot_item_type() == Items.ItemType.RANGED_WEAPON:
				if $HUD/Inventory.get_active_slot_item()['uses'] > 0:
					$HUD/Inventory.get_active_slot_item()['uses'] = $HUD/Inventory.get_active_slot_item()['uses'] - 1
					$Gun.shoot()
					
					print($HUD/Inventory.get_active_slot_item()['uses'])
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
						var tile_id = farm.find_tile_id_by_name(block['properties']['name'])
						farm.set_tile_at_position(get_global_mouse_position(), tile_id, farm.FOREGROUND)
						$HUD/Inventory.remove_item(block['item_id'])
			elif get_active_slot_item_type() == Items.ItemType.FLOORING:
				var tile_pos = farm.position_to_tile_position(get_global_mouse_position())
				var player_tile_pos = farm.position_to_tile_position(global_position)
				
				# Sets tile based on placement range
				if is_within_tile_reach(tile_pos, player_tile_pos):
					var block = $HUD/Inventory.get_active_slot_item()
					
					# Foreground Interactions
					if farm.get_all_tiles_at_tile_position(tile_pos)[farm.FLOORING] == -1:
						var tile_id = farm.find_tile_id_by_name(block['properties']['name'], farm.FLOORING)
						farm.set_tile_at_position(get_global_mouse_position(), tile_id, farm.FLOORING)
						$HUD/Inventory.remove_item(block['item_id'])
			elif get_active_slot_item_type() == Items.ItemType.ROOFING:
				var tile_pos = farm.position_to_tile_position(get_global_mouse_position())
				var player_tile_pos = farm.position_to_tile_position(global_position)
				
				# Sets tile based on placement range
				if is_within_tile_reach(tile_pos, player_tile_pos):
					var block = $HUD/Inventory.get_active_slot_item()
					
					# Foreground Interactions
					if farm.get_all_tiles_at_tile_position(tile_pos)[farm.ROOF] == -1:
						var tile_id = farm.find_tile_id_by_name(block['properties']['name'], farm.ROOF)
						farm.set_tile_at_position(get_global_mouse_position(), tile_id, farm.ROOF)
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

	# Flips sprite if mouse is on the left of player
	# NOTE: does not maintain sprite orientation if mouse exactly at player position
	$Sprite.flip_h = get_global_mouse_position().x < global_position.x

	if last_velocity != velocity:
		last_velocity = velocity
		
	if farm.position_has_roof(global_position):
		if not under_roof:
			farm.hide_roof(global_position)
			roof_pos = global_position
			under_roof = true
	else:
		if under_roof:
			farm.show_roof(roof_pos)
			roof_pos = null
			under_roof = false


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


func use_hoe(tile_pos):
	var background_tile = farm.get_all_tiles_at_tile_position(tile_pos)[farm.BACKGROUND]
	
	if "GRASS" in farm.background_tiles[background_tile]:
		if use_stamina(1):
			farm.set_tile_at_position(get_global_mouse_position(), farm.background_tiles.find("DIRT"), farm.BACKGROUND)
	elif farm.background_tiles[background_tile] == "DIRT":
		if use_stamina(1):
			farm.set_tile_at_position(get_global_mouse_position(), farm.background_tiles.find("TILLED_SOIL"), farm.BACKGROUND)


func use_axe(tile_pos):
	if farm.get_all_tiles_at_tile_position(tile_pos)[farm.FOREGROUND] == 0:
		farm.set_tile_at_position(get_global_mouse_position(), -1, farm.FOREGROUND)
		$HUD/Inventory.add_item(Items.FENCE)
	elif farm.get_all_tiles_at_tile_position(tile_pos)[farm.BACKGROUND] == farm.background_tiles.find("TILLED_SOIL"):
		if use_stamina(1):
			farm.set_tile_at_position(get_global_mouse_position(), farm.background_tiles.find("DIRT"), farm.BACKGROUND)


func use_watering_can(tile_pos):
	if farm.get_all_tiles_at_tile_position(tile_pos)[farm.BACKGROUND] == farm.background_tiles.find("TILLED_SOIL"):
		if use_stamina(1):
			farm.set_tile_at_position(get_global_mouse_position(), farm.background_tiles.find("WATERED_SOIL"), farm.BACKGROUND)
