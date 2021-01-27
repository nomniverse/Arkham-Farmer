extends KinematicBody2D


# Declare member variables here. Examples:
const WITH_FRUIT_TEXTURE = Rect2(32, 176, 32, 32)
const WITHOUT_FRUIT_TEXTURE = Rect2(64, 176, 32, 32)

const DAYS_TO_FRUIT = 6

var growth_days = 0
var can_harvest = false

var player


# Called when the node enters the scene tree for the first time.
func _ready():
	var error = get_tree().get_root().get_node("Game/TimeCycle").connect("day_changed", self, "_on_day_changed")
	
	if error:
		print("Connect failed...")
	
	player = get_tree().get_root().get_node("Game/Player")


func _on_day_changed(_day):
	if growth_days == DAYS_TO_FRUIT:
		can_harvest = true
	else:
		if not can_harvest:
			growth_days += 1
		
	if can_harvest:
		$Sprite.region_rect = WITH_FRUIT_TEXTURE


func _on_AppleTree_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if player.is_within_position_reach(get_global_mouse_position()):
			if can_harvest:
				can_harvest = false
				growth_days = 0
				$Sprite.region_rect = WITHOUT_FRUIT_TEXTURE
				
				get_tree().get_root().get_node("Game/Player/HUD/Hotbar").add_item(Items.Item.APPLE)
