extends Node2D


# Declare member variables here. Examples:
var player

# Preloads
var shine_effect = preload("res://effects/Shine.tscn")

# Crops
var corn = preload("res://plants/Corn.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_root().get_node("Game/Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func get_path_to_position(origin_position, target_position):
	return $Navigation2D.get_simple_path(origin_position, target_position)


func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var tile_pos = $FarmBackground.world_to_map(get_global_mouse_position())
			var player_tile_pos = $FarmBackground.world_to_map(player.global_position)
			
			# Sets tile based on placement range
			if player.is_within_tile_reach(tile_pos, player_tile_pos):
				# Foreground Interactions
				if player.get_node("HUD/Hotbar").get_active_slot_item()['name'] == "Log":
					if $FarmForeground.get_cell(tile_pos.x, tile_pos.y) == -1:
						$FarmForeground.set_cell(tile_pos.x, tile_pos.y, 0)
						$Navigation2D/NavigationTileMap.set_cell(tile_pos.x, tile_pos.y, $Navigation2D/NavigationTileMap.OBSTACLE_TILE)
						
				# Background Interactions
				if player.get_node("HUD/Hotbar").get_active_slot_item()['name'] == "Shovel":
					if $FarmBackground.get_cell(tile_pos.x, tile_pos.y) == 0:
						$FarmBackground.set_cell(tile_pos.x, tile_pos.y, 1)
					elif $FarmBackground.get_cell(tile_pos.x, tile_pos.y) == 1:
						$FarmBackground.set_cell(tile_pos.x, tile_pos.y, 2)
				elif player.get_node("HUD/Hotbar").get_active_slot_item()['name'] == "Axe":
					if $FarmBackground.get_cell(tile_pos.x, tile_pos.y) == 2:
						$FarmBackground.set_cell(tile_pos.x, tile_pos.y, 1)
				elif player.get_node("HUD/Hotbar").get_active_slot_item()['name'] == "Watering Can":
					if $FarmBackground.get_cell(tile_pos.x, tile_pos.y) == 2:
						var shine = shine_effect.instance()
						shine.global_position = $FarmBackground.map_to_world(tile_pos) + Vector2(8, 8)
						shine.play()
						get_parent().add_child(shine)
				elif player.get_node("HUD/Hotbar").get_active_slot_item()['name'] == "Corn Seeds":
					if $FarmBackground.get_cell(tile_pos.x, tile_pos.y) == 2:
						var new_corn = corn.instance()
						new_corn.global_position = $FarmBackground.map_to_world(tile_pos) + Vector2(8, 4)
						get_parent().add_child(new_corn)
						player.get_node("HUD/Hotbar").remove_item(Items.item_properties[Items.Item.CORN_SEEDS])
