extends TextureRect


# Declare member variables here. Examples:
var item = {
	"item_id": Items.NO_ITEM,
	"properties": Items.item_properties[Items.NO_ITEM],
	"quantity": 0,
	"uses": 0
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	rect_global_position = get_global_mouse_position()


func set_item(item_id, amount=1):
	item['item_id'] = item_id
	item['properties'] = Items.item_properties[item_id]
	item['quantity'] = amount
	
	texture.atlas = item['properties']['texture_file']
	texture.region = item['properties']['icon']


func get_item():
	return item
