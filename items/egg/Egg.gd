extends Area2D


# Declare member variables here. Examples:
var player


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_root().get_node("Game/Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Egg_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		# Sets tile based on placement range
		if player.is_within_position_reach(get_global_mouse_position()):
			get_tree().get_root().get_node("Game/Player/HUD/Hotbar").add_item(Items.Item.EGG)
			self.queue_free()
