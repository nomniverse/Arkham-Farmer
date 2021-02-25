extends Bag


# Declare member variables here. Examples:
var active_slot = 0


func get_active_slot_item():
	return get_child(active_slot).item


# Called when the node enters the scene tree for the first time.
func _ready():
	get_child(active_slot).set_active()
	
	# Preloads inventory with items
	# TODO Read inventory from save file
	add_item(Items.WATER_CAN)
	add_item(Items.PICKAXE)
	add_item(Items.AXE)
	add_item(Items.HOE)
	add_item(Items.CORN_SEEDS)
	add_item(Items.LOG)
	add_item(Items.REVOLVER)
	add_item(Items.BULLET, 12)
	
	for i in range(64):
		add_item(Items.FENCE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP and not Globals.crafting_menu_open:
				get_child(active_slot).set_inactive()
				
				if active_slot == 9:
					active_slot = 0
				else:
					active_slot += 1
					
				get_child(active_slot).set_active()
				
			if event.button_index == BUTTON_WHEEL_DOWN and not Globals.crafting_menu_open:
				get_child(active_slot).set_inactive()
				
				if active_slot == 0:
					active_slot = 9
				else:
					active_slot -= 1
				
				get_child(active_slot).set_active()
	
	if event is InputEventKey:
		if event.pressed:
			_check_for_hotbar_key(event.scancode)


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


func _on_BagSlot_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and not Globals.bag_open:
			get_child(active_slot).set_inactive()
			active_slot = 0
			get_child(active_slot).set_active()


func _on_BagSlot2_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and not Globals.bag_open:
			get_child(active_slot).set_inactive()
			active_slot = 1
			get_child(active_slot).set_active()


func _on_BagSlot3_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and not Globals.bag_open:
			get_child(active_slot).set_inactive()
			active_slot = 2
			get_child(active_slot).set_active()


func _on_BagSlot4_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and not Globals.bag_open:
			get_child(active_slot).set_inactive()
			active_slot = 3
			get_child(active_slot).set_active()


func _on_BagSlot5_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and not Globals.bag_open:
			get_child(active_slot).set_inactive()
			active_slot = 4
			get_child(active_slot).set_active()


func _on_BagSlot6_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and not Globals.bag_open:
			get_child(active_slot).set_inactive()
			active_slot = 5
			get_child(active_slot).set_active()


func _on_BagSlot7_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and not Globals.bag_open:
			get_child(active_slot).set_inactive()
			active_slot = 6
			get_child(active_slot).set_active()


func _on_BagSlot8_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and not Globals.bag_open:
			get_child(active_slot).set_inactive()
			active_slot = 7
			get_child(active_slot).set_active()


func _on_BagSlot9_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and not Globals.bag_open:
			get_child(active_slot).set_inactive()
			active_slot = 8
			get_child(active_slot).set_active()


func _on_BagSlot10_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and not Globals.bag_open:
			get_child(active_slot).set_inactive()
			active_slot = 9
			get_child(active_slot).set_active()
