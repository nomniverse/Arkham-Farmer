extends Area2D


# Declare member variables here. Examples:
var item = {
	"item_id": Items.NO_ITEM,
	"properties": Items.item_properties[Items.NO_ITEM],
	"quantity": 0
}

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_root().get_node("Game/Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func set_item(item_id, amount=1):
	item['item_id'] = item_id
	item['properties'] = Items.item_properties[item_id]
	
	$Sprite.texture.atlas = item['properties']['texture_file']
	$Sprite.texture.region = item['properties']['icon']
	item['quantity'] = amount


func _on_Pickup_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		# Sets tile based on placement range
		if player.is_within_position_reach(get_global_mouse_position()) and player.get_active_slot_item_type() == item['properties']['pickup_tool']:
			get_tree().get_root().get_node("Game/Player/HUD/Inventory").add_item(item['item_id'])
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
			self.queue_free()


func _on_Pickup_body_entered(body):
	pass # Replace with function body.


func _on_Pickup_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_Pickup_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
