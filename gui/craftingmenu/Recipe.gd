extends Control


signal recipe_selected(recipe)


# Declare member variables here. Examples:
var item = {
	"item_id": Items.NO_ITEM,
	"properties": Items.item_properties[Items.NO_ITEM],
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func set_item(item_id):
	item["item_id"] = item_id
	item["properties"] = Items.item_properties[item_id]
	
	$RecipeNameLabel.text = item['properties']['name']
	$OutputTextureRect.texture.atlas = item['properties']['texture_file']
	$OutputTextureRect.texture.region = item['properties']['icon']


func _on_Recipe_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal('recipe_selected', item)
