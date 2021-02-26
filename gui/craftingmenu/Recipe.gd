extends Control


signal recipe_selected(recipe)


# Declare member variables here. Examples:
var recipe = {
	'ingredients': [],
	'time': '0',
	'output': {
		'name': '',
		'texture': Rect2()
	}
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Recipe_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal('recipe_selected', recipe)
