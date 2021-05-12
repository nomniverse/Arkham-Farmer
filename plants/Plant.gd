extends Area2D


export(Array, int) var stage_durations = [1, 1, -1]
export (bool) var can_reharvest = false

const STEM_SPRITE = Rect2(32, 64, 32, 32)
const PLANT_SPRITE = Rect2(0, 64, 32, 32)

const NO_FRUIT_SPRITE = Rect2(288, 64, 32, 32)

var stage = 0
var stage_days = 0
var can_harvest = false

var plant_type = Crops.NONE

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	var error = get_tree().get_root().get_node("Game/TimeCycle").connect("day_changed", self, "_on_day_changed")
	
	if error:
		print("Connect failed...")
	
	player = get_tree().get_root().get_node("Game/Player")
	
	$PlantSprite.region_rect = STEM_SPRITE
	$FruitSprite.region_rect = NO_FRUIT_SPRITE


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func set_crop_type_by_seed(seed_id):
	if Items.item_properties[seed_id]['item_type'] == Items.ItemType.SEED:
		plant_type = Crops.get_crop_by_seed(seed_id)
	else:
		print("Invalid crop id")


func _on_day_changed(_day):
	if stage_days == stage_durations[stage]:
		stage += 1
		stage_days = 0
	else:
		stage_days += 1
	
	if stage == 2:
		can_harvest = true
		var fruit_id = Crops.crop_properties[plant_type]['fruit']
		$FruitSprite.region_rect = Items.item_properties[fruit_id]['icon']
	elif stage == 1:
		$PlantSprite.region_rect = PLANT_SPRITE
	else:
		pass


func _on_Plant_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		# Sets tile based on placement range
		if player.is_within_position_reach(get_global_mouse_position()):
			if can_harvest:
				get_tree().get_root().get_node("Game/Player/HUD/Inventory").add_item(Items.CORN)
				
				if can_reharvest:
					stage = 1
					$FruitSprite.region_rect = NO_FRUIT_SPRITE
				else:
					self.queue_free()
