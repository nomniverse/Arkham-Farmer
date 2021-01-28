extends KinematicBody2D


# Declare member variables here. Examples:
var player

var inventory = []


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_root().get_node("Game/Player")
	
	inventory.append({
		'id': Items.BULLET,
		'quantity': 6,
	})


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Container_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		# Sets tile based on placement range
		if player.is_within_position_reach(get_global_mouse_position()):
			if inventory.size() != 0:
				for i in inventory.size():
					var item = inventory.pop_front()
					get_tree().get_root().get_node("Game/Player/HUD/Hotbar").add_item(item['id'], item['quantity'])
					
				$Sprite.region_rect = Items.item_properties[Items.BOX]['empty_icon']
