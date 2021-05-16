extends Panel


signal slot_selected(item)


# Declare member variables here. Examples:
var item = {
	"item_id": Items.NO_ITEM,
	"properties": Items.item_properties[Items.NO_ITEM],
	"quantity": 0,
	"uses": 0
}

const DRAG_ITEM = preload('res://items/DragItem/DragItem.tscn')

export (int) var slot_number = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Highlights slot as active slot
func set_active():
	self_modulate = Color(1, 0, 0, 1)
	
	if item['properties']['item_type'] == Items.ItemType.RANGED_WEAPON:
		Input.set_default_cursor_shape(Input.CURSOR_CROSS)


# Unhighlights slot as active slot
func set_inactive():
	self_modulate = Color(1, 1, 1, 1)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func set_item(item_id, amount=1):
	if item['item_id'] == item_id:
		set_quantity(get_quantity() + amount)
	else:
		item['item_id'] = item_id
		item['properties'] = Items.item_properties[item_id]
		
		$ItemIcon.texture.atlas = item['properties']['texture_file']
		$ItemIcon.texture.region = item['properties']['icon']
		set_quantity(amount)


func get_item():
	return item


func get_quantity():
	return item['quantity']


func set_quantity(quantity):
	if quantity < 0:
		return false
	
	item['quantity'] = quantity
	
	if not ((item['quantity'] == 0) or (item['quantity'] == 1)):
		$ItemQuantity.text = str(item['quantity'])
	else:
		$ItemQuantity.text = ""
		
	if item['quantity'] <= 0:
		item = {
			"item_id": Items.NO_ITEM,
			"properties": Items.item_properties[Items.NO_ITEM],
			"quantity": 0,
			"uses": 0
		}
		
		$ItemIcon.texture.atlas = item['properties']['texture_file']
		$ItemIcon.texture.region = item['properties']["icon"]

	return true

func get_uses():
	return item['uses']
	
	
func set_uses(uses):
	item['uses'] = uses


func is_empty():
	return get_quantity() == 0


func empty():
	set_quantity(0)


func _on_BagSlot_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if Globals.bag_open:
				if Globals.dragging_item:
					var drag_item_node = get_tree().get_root().get_node('Game/Player/HUD/DragItem')
					
					if is_empty():
						set_item(drag_item_node.get_item()['item_id'], drag_item_node.get_item()['quantity'])
						drag_item_node.queue_free()
						Globals.dragging_item = false
					else:
						var temp_item = get_item().duplicate()
						
						set_item(drag_item_node.get_item()['item_id'], drag_item_node.get_item()['quantity'])
						
						if temp_item['item_id'] == drag_item_node.get_item()['item_id']:
							drag_item_node.queue_free()
							Globals.dragging_item = false
						else:
							drag_item_node.set_item(temp_item['item_id'], temp_item['quantity'])
				else:
					var dragItem = DRAG_ITEM.instance()
					dragItem.set_item(item['item_id'], item['quantity'])
					
					get_tree().get_root().get_node('Game/Player/HUD').add_child(dragItem)
					empty()
					Globals.dragging_item = true
			else:
				emit_signal('slot_selected', slot_number)
