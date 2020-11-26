extends Area2D


export(Array, int) var stage_frames
export(Array, int) var stage_durations
export (bool) var can_reharvest = false
export (int) var reharvest_stage = 1


var stage = 0
var stage_days = 0
var can_harvest = false

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().get_node("Game/TimeCycle").connect("day_changed", self, "_on_day_changed")
	
	player = get_tree().get_root().get_node("Game/Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_day_changed(_day):
	if stage == stage_frames.size() - 1:
		can_harvest = true
	else:
		if stage_days == stage_durations[stage]:
			stage += 1
		else:
			stage_days += 1
		
		$Sprite.frame = stage_frames[stage]


func _on_Plant_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		# Sets tile based on placement range
		if player.is_within_position_reach(get_global_mouse_position()):
			if can_harvest:
				get_tree().get_root().get_node("Game/Player/HUD/Hotbar").add_item(Items.Item.CORN)
				
				if can_reharvest:
					stage = reharvest_stage
					$Sprite.frame = stage_frames[stage]
				else:
					self.queue_free()
