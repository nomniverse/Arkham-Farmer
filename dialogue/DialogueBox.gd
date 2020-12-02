extends Control


# Declare member variables here
const CONVERSATION_DIR = "res://dialogue/data"

var conversation
var current_part = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	if not visible:
		_disable_input()


func load_conversation(character_name, conversation_name):
	# Opens the file
	var file = File.new()
	var filepath = CONVERSATION_DIR + "/" + character_name + "/" + conversation_name + ".json"
	file.open(filepath, file.READ)
	
	# Converts the file to JSON and closes it
	var json = file.get_as_text()
	file.close()
	conversation = JSON.parse(json).result
	
	# Displays the conversation's first part
	_display_dialogue(current_part)
	visible = true


func _display_dialogue(part):
	part = str(part)
	
	$NamePanel/NameLabel.text = conversation[part]['name']
	$TextPanel/TextLabel.text = conversation[part]['text']


func _next():
	current_part += 1
	
	if current_part != conversation.size():
		_display_dialogue(current_part)
	else:
		current_part = 0
		visible = false


func _disable_input():
	set_process_input(false)


func _enable_input():
	set_process_input(true)


func _on_DialogueBox_visibility_changed():
	if is_visible_in_tree():
		_enable_input()
	else:
		_disable_input()


func _on_DialogueBox_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			_next()
