extends Panel


var item = {
	"item_id": Items.NO_ITEM,
	"properties": Items.item_properties[Items.NO_ITEM],
	"quantity": 0,
	"uses": 0
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_item(item_id, amount=1):
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
	item['quantity'] = quantity
	
	if not ((item['quantity'] == 0) or (item['quantity'] == 1)):
		$ItemQuantity.text = str(item['quantity'])
	else:
		$ItemQuantity.text = ""
		
	if item['quantity'] <= 0:
		item = {
			"item_id": Items.NO_ITEM,
			"properties": Items.item_properties[Items.NO_ITEM],
		}
		
		$ItemIcon.texture.atlas = item['properties']['texture_file']
		$ItemIcon.texture.region = item['properties']["icon"]


func get_uses():
	return item['uses']
	
	
func set_uses(uses):
	item['uses'] = uses


func empty():
	set_quantity(0)


# Highlights slot as active slot
func set_active():
	self_modulate = Color(1, 0, 0, 1)
	
	if item['properties']['item_type'] == Items.ItemType.RANGED_WEAPON:
		Input.set_default_cursor_shape(Input.CURSOR_CROSS)


# Unhighlights slot as active slot
func set_inactive():
	self_modulate = Color(1, 1, 1, 1)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
