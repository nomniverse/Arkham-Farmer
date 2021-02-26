extends Bag


# Declare member variables here. Examples:
var active_slot = 0


func get_active_slot_item():
	return get_child(active_slot).item


func empty_active_slot():
	empty_slot(active_slot)


# Called when the node enters the scene tree for the first time.
func _ready():
	for slot in get_children():
		slot.connect('slot_selected', self, '_on_slot_selected')
	
	get_child(active_slot).set_active()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and not Globals.crafting_menu_open:
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


func _check_for_hotbar_key(scancode):
	if scancode >= KEY_0 and scancode <= KEY_9:
		get_child(active_slot).set_inactive()
		
		if scancode == KEY_1:
			active_slot = 0
		elif scancode == KEY_2:
			active_slot = 1
		elif scancode == KEY_3:
			active_slot = 2
		elif scancode == KEY_4:
			active_slot = 3
		elif scancode == KEY_5:
			active_slot = 4
		elif scancode == KEY_6:
			active_slot = 5
		elif scancode == KEY_7:
			active_slot = 6
		elif scancode == KEY_8:
			active_slot = 7
		elif scancode == KEY_9:
			active_slot = 8
		elif scancode == KEY_0:
			active_slot = 9
			
		get_child(active_slot).set_active()


func _on_slot_selected(slot_number):
	if not Globals.bag_open:
		get_child(active_slot).set_inactive()
		active_slot = slot_number
		get_child(active_slot).set_active()
