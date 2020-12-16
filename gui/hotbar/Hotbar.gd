extends Control


# Declare member variables here. Examples:
var active_slot = 0


func get_active_slot_item():
	return get_child(active_slot).item


# Called when the node enters the scene tree for the first time.
func _ready():
	get_child(active_slot).set_active()
	
	# Preloads inventory with items
	# TODO Read inventory from save file
	add_item(Items.Item.WATER_CAN)
	add_item(Items.Item.SHOVEL)
	add_item(Items.Item.AXE)
	add_item(Items.Item.CORN_SEEDS)
	add_item(Items.Item.LOG)
	add_item(Items.Item.REVOLVER)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				get_child(active_slot).set_inactive()
				
				if active_slot == 9:
					active_slot = 0
				else:
					active_slot += 1
					
				get_child(active_slot).set_active()
				
			if event.button_index == BUTTON_WHEEL_DOWN:
				get_child(active_slot).set_inactive()
				
				if active_slot == 0:
					active_slot = 9
				else:
					active_slot -= 1
				
				get_child(active_slot).set_active()
	
	if event is InputEventKey:
		if event.pressed:
			_check_for_hotbar_key(event.scancode)


func add_item(id):
	var empty_slot = -1
	
	var i = 0
	
	for child in get_children():
		if child.get_item()['name'] == "" and empty_slot == -1:
			empty_slot = i
		elif child.get_item()['name'] == Items.item_properties[id]['name']:
			child.set_quantity(child.get_quantity() + 1)
			return
			
		i += 1
		
	if empty_slot != -1:
		get_children()[empty_slot].set_item(id)
	else:
		print("No empty slot found... Item lost.")
	
	
func remove_item(id):
	var item = Items.item_properties[id]
	
	for child in get_children():
		if child.get_item()['name'] == item['name']:
			child.set_quantity(child.get_quantity() - 1)
			return
			
	print("Item not found...")
	
	
func empty_slot(number):
	get_child(number).empty()
	
	
func empty_active_slot():
	empty_slot(active_slot)


func _check_for_hotbar_key(scancode):
	if scancode == KEY_1:
		get_child(active_slot).set_inactive()
		active_slot = 0
		get_child(active_slot).set_active()
		
	if scancode == KEY_2:
		get_child(active_slot).set_inactive()
		active_slot = 1
		get_child(active_slot).set_active()
		
	if scancode == KEY_3:
		get_child(active_slot).set_inactive()
		active_slot = 2
		get_child(active_slot).set_active()
		
	if scancode == KEY_4:
		get_child(active_slot).set_inactive()
		active_slot = 3
		get_child(active_slot).set_active()
		
	if scancode == KEY_5:
		get_child(active_slot).set_inactive()
		active_slot = 4
		get_child(active_slot).set_active()
		
	if scancode == KEY_6:
		get_child(active_slot).set_inactive()
		active_slot = 5
		get_child(active_slot).set_active()
		
	if scancode == KEY_7:
		get_child(active_slot).set_inactive()
		active_slot = 6
		get_child(active_slot).set_active()
		
	if scancode == KEY_8:
		get_child(active_slot).set_inactive()
		active_slot = 7
		get_child(active_slot).set_active()
		
	if scancode == KEY_9:
		get_child(active_slot).set_inactive()
		active_slot = 8
		get_child(active_slot).set_active()
		
	if scancode == KEY_0:
		get_child(active_slot).set_inactive()
		active_slot = 9
		get_child(active_slot).set_active()


func _on_HotbarSlot_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			get_child(active_slot).set_inactive()
			active_slot = 0
			get_child(active_slot).set_active()


func _on_HotbarSlot2_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			get_child(active_slot).set_inactive()
			active_slot = 1
			get_child(active_slot).set_active()


func _on_HotbarSlot3_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			get_child(active_slot).set_inactive()
			active_slot = 2
			get_child(active_slot).set_active()


func _on_HotbarSlot4_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			get_child(active_slot).set_inactive()
			active_slot = 3
			get_child(active_slot).set_active()


func _on_HotbarSlot5_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			get_child(active_slot).set_inactive()
			active_slot = 4
			get_child(active_slot).set_active()


func _on_HotbarSlot6_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			get_child(active_slot).set_inactive()
			active_slot = 5
			get_child(active_slot).set_active()


func _on_HotbarSlot7_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			get_child(active_slot).set_inactive()
			active_slot = 6
			get_child(active_slot).set_active()


func _on_HotbarSlot8_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			get_child(active_slot).set_inactive()
			active_slot = 7
			get_child(active_slot).set_active()


func _on_HotbarSlot9_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			get_child(active_slot).set_inactive()
			active_slot = 8
			get_child(active_slot).set_active()


func _on_HotbarSlot10_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			get_child(active_slot).set_inactive()
			active_slot = 9
			get_child(active_slot).set_active()
