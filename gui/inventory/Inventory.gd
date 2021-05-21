extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.bag_open = $Backpack.visible
	
	# Preloads inventory with items
	# TODO Read inventory from save file
	add_item(Items.WATER_CAN)
	add_item(Items.PICKAXE)
	add_item(Items.AXE)
	add_item(Items.HOE)
	add_item(Items.BROCCOLI_SEEDS)
	add_item(Items.LOG, 64)
	add_item(Items.REVOLVER)
	add_item(Items.BULLET, 12)
	add_item(Items.FENCE, 32)
	add_item(Items.WALL, 64)
	add_item(Items.FLOORING, 64)
	add_item(Items.ROOFING, 64)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.is_action_pressed("toggle_backpack"):
				$Backpack.visible = not $Backpack.visible
				Globals.bag_open = $Backpack.visible


func get_active_slot_item():
	return $Hotbar.get_active_slot_item()


func get_item_at_slot(slot):
	return $Hotbar.get_item_at_slot(slot)


func add_item(item_id, quantity=1):
	var slot = $Hotbar.add_item(item_id, quantity)
	
	if slot == null:
		slot = $Backpack.add_item(item_id, quantity)
		
	return slot
	
	
func remove_item(item_id, quantity=1):
	var slot = $Hotbar.remove_item(item_id, quantity)
	
	if slot == null:
		slot = $Backpack.remove_item(item_id, quantity)
		
	return slot
	
	
func find_item_slot(item_id):
	var slot = $Hotbar.find_item_slot(item_id)
	
	if slot == null:
		slot = $Backpack.find_item_slot(item_id)
		
	return slot
	
	
func empty_slot(number):
	$Hotbar.empty_slot(number)
	
	
func empty_active_slot():
	$Hotbar.empty_active_slot()
