extends KinematicBody2D


# Declare member variables here. Examples:
export (bool) var is_stone = true

var item = {
	"item_id": Items.NO_ITEM,
	"properties": Items.item_properties[Items.NO_ITEM],
	"quantity": 0
}

var player


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_root().get_node("Game/Player")
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	if is_stone:
		item = {
			'item_id': Items.RAW_STONE,
			'properties': Items.item_properties[Items.RAW_STONE],
			'quantity': rng.randi_range(1, 3)
		}
	else:
		var rocks = Items.get_items_of_type(Items.ItemType.ROCK)
		var item_id = rocks[rng.randi_range(1, rocks.size() - 1)]
		
		item = {
			'item_id': item_id,
			'properties': Items.item_properties[item_id],
			'quantity': rng.randi_range(1, 3)
		}
		
	$Sprite.texture = $Sprite.texture.duplicate() # IDK why, but editor "Make Unique" does not work
	$Sprite.texture.atlas = item['properties']['texture_file']
	var icon_idx = rng.randi_range(0, item['properties']['icon'].size() - 1)
	$Sprite.texture.region = item['properties']['icon'][icon_idx]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func set_item(item_id, amount=1):
	item['item_id'] = item_id
	item['properties'] = Items.item_properties[item_id]
	
	$Sprite.texture.atlas = item['properties']['texture_file']
	$Sprite.texture.region = item['properties']['icon']
	item['quantity'] = amount


func _on_Rock_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		# Sets tile based on placement range
		if player.is_within_position_reach(get_global_mouse_position()):
			if item['properties'].has('drop'):
				get_tree().get_root().get_node("Game/Player/HUD/Inventory").add_item(item['properties']['drop'], item['quantity'])
			else:
				get_tree().get_root().get_node("Game/Player/HUD/Inventory").add_item(item['item_id'], item['quantity'])
			
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
			self.queue_free()


func _on_Rock_body_entered(_body):
	pass # Replace with function body.


func _on_Rock_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_Rock_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
