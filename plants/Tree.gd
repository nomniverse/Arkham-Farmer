extends KinematicBody2D


# Declare member variables here. Examples:
const NO_FRUIT_TEXTURE = Rect2(352, 256, 32, 32)
const DAYS_TO_FRUIT = 1

enum TREE_TYPE {
	DECIDUOUS,
	CONIFEROUS,
	APPLE,
	ORANGE,
	PEAR,
	PEACH,
	CHERRY,
}

export (TREE_TYPE) var tree_type

var fruit_id
var fruit_texture

var growth_days = 0
var can_harvest = false

var player


# Called when the node enters the scene tree for the first time.
func _ready():
	var error = get_tree().get_root().get_node("Game/TimeCycle").connect("day_changed", self, "_on_day_changed")
	
	if error:
		print("Connect failed...")
	
	player = get_tree().get_root().get_node("Game/Player")
	
	if tree_type == TREE_TYPE.APPLE:
		fruit_id = Items.APPLE
	elif tree_type == TREE_TYPE.ORANGE:
		fruit_id = Items.ORANGE
	elif tree_type == TREE_TYPE.PEAR:
		fruit_id = Items.PEAR
	elif tree_type == TREE_TYPE.PEACH:
		fruit_id = Items.PEACH
	elif tree_type == TREE_TYPE.CHERRY:
		fruit_id = Items.CHERRY
	
	if tree_type != TREE_TYPE.DECIDUOUS and tree_type != TREE_TYPE.CONIFEROUS:
		fruit_texture = Items.item_properties[fruit_id]['small_icon']


func _on_day_changed(_day):
	if tree_type != TREE_TYPE.DECIDUOUS and tree_type != TREE_TYPE.CONIFEROUS:
		if growth_days == DAYS_TO_FRUIT:
			can_harvest = true
			
			$Fruit0Sprite.region_rect = fruit_texture
			$Fruit1Sprite.region_rect = fruit_texture
		else:
			if not can_harvest:
				growth_days += 1


func _on_AppleTree_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if player.is_within_position_reach(get_global_mouse_position()):
			if can_harvest:
				can_harvest = false
				growth_days = 0
				
				$Fruit0Sprite.region_rect = NO_FRUIT_TEXTURE
				$Fruit1Sprite.region_rect = NO_FRUIT_TEXTURE
				
				get_tree().get_root().get_node("Game/Player/HUD/Hotbar").add_item(fruit_id, 2)


func _on_Tree_mouse_entered():
	if can_harvest:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_Tree_mouse_exited():
	if can_harvest:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
