extends Control


# Declare member variables here. Examples:
var current_item = {
	"item_id": Items.NO_ITEM,
	"properties": Items.item_properties[Items.NO_ITEM],
}

var Recipe = preload('res://gui/craftingmenu/Recipe.tscn')


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.crafting_menu_open = $Menu.visible
	
	for item_id in Items.item_properties:
		if not Items.item_properties[item_id]['recipe']['ingredients'].empty():
			var recipe = Recipe.instance()
			recipe.set_item(item_id)
			recipe.connect("recipe_selected", self, "_on_Recipe_selected")
			$Menu/RecipeContainer/VBoxContainer.add_child(recipe)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.is_action_pressed("toggle_crafting_menu"):
				$Menu.visible = not $Menu.visible
				Globals.crafting_menu_open = $Menu.visible
				
			if event.is_action_pressed("close_inventory"):
				$Menu.visible = false
				Globals.crafting_menu_open = false


func _on_Recipe_selected(item):
	current_item = item
	
	$Menu/OutputTextureRect.texture.atlas = current_item['properties']['texture_file']
	$Menu/OutputTextureRect.texture.region = current_item['properties']['icon']
	
	$Menu/OutputName.text = current_item['properties']['name']
	
	$Menu/IngredientsList.text = ''
	
	for item_id in current_item['properties']['recipe']['ingredients']:
		var item_name = Items.item_properties[item_id]['name']
		var quantity = current_item['properties']['recipe']['ingredients'][item_id]
		
		$Menu/IngredientsList.text += "{item_name}: {quantity}\n".format({
			'item_name': item_name,
			'quantity': quantity
			})


func _on_CraftButton_pressed():
	var player_inventory = get_parent().get_node('Inventory')
	
	for ingredient in current_item['properties']['recipe']['ingredients']:
		if player_inventory.remove_item(ingredient, current_item['properties']['recipe']['ingredients'][ingredient]) != null:
			player_inventory.add_item(current_item['item_id'])
