extends TileMap


# Scenes
var player


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_root().get_node("Game/Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			var tile_pos = world_to_map(get_global_mouse_position())
			var player_tile_pos = world_to_map(player.global_position)
			
			# Sets tile based on placement range
			if player.is_within_tile_reach(tile_pos, player_tile_pos):
				if player.get_node("HUD/Hotbar").get_active_slot_item()['name'] == "Log":
					if get_cell(tile_pos.x, tile_pos.y) == -1:
						set_cell(tile_pos.x, tile_pos.y, 0)
