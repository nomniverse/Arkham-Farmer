extends TileMap


# Tileset sprites
const IN_RANGE_INDICATOR = 0
const OUT_RANGE_INDICATOR = 1

# Settings
const PLACEMENT_TILE_RANGE = 2

# Member variables
var last_tile_pos = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# Called when input is detected
func _input(event):
	if event is InputEventMouseMotion:
		var tile_pos = world_to_map(get_global_mouse_position())
		var player_tile_pos = world_to_map(get_tree().get_root().get_node("Game/Player").global_position)
		
		# Sets tile based on placement range
		if abs(tile_pos.x - player_tile_pos.x) <= PLACEMENT_TILE_RANGE and abs(tile_pos.y - player_tile_pos.y) <= PLACEMENT_TILE_RANGE:
			set_cell(tile_pos.x, tile_pos.y, IN_RANGE_INDICATOR)
		else:
			if Settings.always_show_indicator:
				set_cell(tile_pos.x, tile_pos.y, OUT_RANGE_INDICATOR)
		
		# Clears last indicator tile
		if tile_pos != last_tile_pos:
			set_cell(last_tile_pos.x, last_tile_pos.y, -1)
			last_tile_pos = tile_pos
