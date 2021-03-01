extends Control


class_name Bag


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func add_item(item_id, quantity=1):
	var empty_slot = -1
	
	for i in get_child_count():
		var child = get_child(i)
		
		if child.get_item()['item_id'] == Items.NO_ITEM and empty_slot == -1:
			empty_slot = i
		elif child.get_item()['item_id'] == item_id:
			child.set_quantity(child.get_quantity() + quantity)
			
			return i
	
	if empty_slot != -1:
		get_children()[empty_slot].set_item(item_id)
		get_children()[empty_slot].set_quantity(quantity)
		
		return empty_slot
	else:
		print("No empty slot found... Item lost.")
	
	return null


func get_item_at_slot(slot):
	return get_child(slot).item


func remove_item(item_id, quantity=1):
	for i in get_child_count():
		var child = get_child(i)
		
		if child.get_item()['item_id'] == item_id:
			var completed = child.set_quantity(child.get_quantity() - quantity)
			
			if completed:
				return i
	
	return null
	
	
func find_item_slot(item_id):
	for i in get_child_count():
		if get_child(i).get_item()['item_id'] == item_id:
			return i
	
	return null
	
	
func empty_slot(number):
	get_child(number).empty()
