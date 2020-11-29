extends TileMap


# Declare member variables here. Examples:
const PATH_TILE = 0
const OBSTACLE_TILE = 1

var background
var foreground


# Called when the node enters the scene tree for the first time.
func _ready():
	background = get_parent().get_parent().get_node("FarmBackground")
	foreground = get_parent().get_parent().get_node("FarmForeground")

	_combine_tilemaps()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _combine_tilemaps():
	var foreground_cells = foreground.get_used_cells()
	
	for tile in foreground_cells:
		set_cell(tile.x, tile.y, OBSTACLE_TILE)
		
	var background_cells = background.get_used_cells()
		
	for tile in background_cells:
		if get_cell(tile.x, tile.y) == -1:
			set_cell(tile.x, tile.y, PATH_TILE)
