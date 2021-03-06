extends Node2D


# Declare member variables here. Examples:
enum {
	FOREGROUND,
	BACKGROUND
}

var background_tiles = []
var foreground_tiles = []

var rng = RandomNumberGenerator.new()

# Crops
var plant = preload("res://plants/Plant.tscn")
var Pickup = preload('res://items/Pickup/Pickup.tscn')


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	
	for tile_id in $FarmBackground.tile_set.get_tiles_ids():
		background_tiles.append($FarmBackground.tile_set.tile_get_name(tile_id))
	
	for tile_id in $FarmForeground.tile_set.get_tiles_ids():
		foreground_tiles.append($FarmForeground.tile_set.tile_get_name(tile_id))


func get_path_to_position(origin_position, target_position):
	return $Navigation2D.get_simple_path(origin_position, target_position)
	
	
func position_to_tile_position(position):
	return $FarmBackground.world_to_map(position)
	
	
func get_all_tiles_at_tile_position(position):
	var tiles = {
		BACKGROUND: $FarmBackground.get_cell(position.x, position.y),
		FOREGROUND: $FarmForeground.get_cell(position.x, position.y),
	}
	
	return tiles


func get_all_tiles_at_position(position):
	var tile_pos = position_to_tile_position(position)
	return get_all_tiles_at_tile_position(tile_pos)
	
	
func set_tile_at_tile_position(position, tile, layer=FOREGROUND):
	if layer == FOREGROUND:
		$FarmForeground.set_cell(position.x, position.y, tile)
		
		if tile == -1:
			$Navigation2D/NavigationTileMap.set_cell(position.x, position.y, $Navigation2D/NavigationTileMap.PATH_TILE)
		else:
			$Navigation2D/NavigationTileMap.set_cell(position.x, position.y, $Navigation2D/NavigationTileMap.OBSTACLE_TILE)
	elif layer == BACKGROUND:
		$FarmBackground.set_cell(position.x, position.y, tile)
	else:
		print("Invalid layer")


func set_tile_at_position(position, tile, layer=FOREGROUND):
	var tile_pos = $FarmBackground.world_to_map(position)
	set_tile_at_tile_position(tile_pos, tile, layer)
	
	if layer == BACKGROUND:
		$FarmBackground.update_bitmask_area(tile_pos)
	elif layer == FOREGROUND:
		$FarmForeground.update_bitmask_area(tile_pos)


func find_tile_id_by_name(tile_name, layer=FOREGROUND):
	if layer == FOREGROUND:
		return $FarmForeground.tile_set.find_tile_by_name(tile_name)
	elif layer == BACKGROUND:
		return $FarmBackground.tile_set.find_tile_by_name(tile_name)


func place_crop(tile_position, crop_name):
	var new_crop
	new_crop = plant.instance()
	new_crop.global_position = $FarmBackground.map_to_world(tile_position) + Vector2(16, 8)
	$Crops.add_child(new_crop)


func position_has_roof(position):
	var tile_pos = position_to_tile_position(position)
	
	return $Roofs.get_cellv(tile_pos) != -1


func hide_roof(position):
	var tile_pos = position_to_tile_position(position)
	
	$Roofs.visible = false


func show_roof(position):
	var tile_pos = position_to_tile_position(position)
	
	$Roofs.visible = true


func drop_pickup(item_id, position, amount=1, drop_random=false):
	var new_pickup
	new_pickup = Pickup.instance()
	new_pickup.set_item(item_id, amount)
	
	var position_deviation = Vector2.ZERO
	
	if drop_random:
		position_deviation.x = rng.randi_range(-32, 32)
		position_deviation.y = rng.randi_range(-32, 32)
	
	new_pickup.global_position = position + position_deviation
	$Pickups.add_child(new_pickup)
