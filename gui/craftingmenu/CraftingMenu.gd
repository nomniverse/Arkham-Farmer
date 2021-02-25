extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.crafting_menu_open = $Menu.visible
	
	for child in $Menu/RecipeContainer/VBoxContainer.get_children():
		child.connect("recipe_selected", self, "_on_Recipe_selected")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.is_action_pressed("toggle_crafting_menu"):
				$Menu.visible = not $Menu.visible
				Globals.crafting_menu_open = $Menu.visible


func _on_Recipe_selected(recipe):
	print(recipe)
