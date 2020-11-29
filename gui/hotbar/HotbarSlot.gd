extends Panel


var item = Items.item_properties[Items.Item.NO_ITEM]
var item_quantity = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func set_item(item_id, amount=1):
	item = Items.item_properties[item_id]
	get_node("ItemIcon").texture.region = item["icon"]
	set_quantity(amount)


func get_item():
	return item


func get_quantity():
	return item_quantity


func set_quantity(quantity):
	item_quantity = quantity
	
	if not ((item_quantity == 0) or (item_quantity == 1)):
		$ItemQuantity.text = str(item_quantity)
	else:
		$ItemQuantity.text = ""
		
	if item_quantity == 0:
		item = Items.item_properties[Items.Item.NO_ITEM]
		get_node("ItemIcon").texture.region = item["icon"]


func empty():
	item = Items.item_properties[Items.Item.NO_ITEM]
	get_node("ItemIcon").texture.region = item["icon"]
	set_quantity(0)


# Highlights slot as active slot
func set_active():
	self_modulate = Color(1, 0, 0, 1)


# Unhighlights slot as active slot
func set_inactive():
	self_modulate = Color(1, 1, 1, 1)
