extends Bag


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass





func _disable_input():
	set_process_input(false)


func _enable_input():
	set_process_input(true)


func _on_Inventory_visibility_changed():
	if is_visible_in_tree():
		_enable_input()
	else:
		_disable_input()
