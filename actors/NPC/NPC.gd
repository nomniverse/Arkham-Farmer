extends Actor


# Declare member variables here. Examples:
export(String) var npc_name = "NPC"

var met_player = false

var walk_speed = 200
var run_speed = 400

var player


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_root().get_node("Game/Player")
	
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process(_delta):
	#velocity = Vector2.ZERO
	
	velocity = velocity.normalized() * walk_speed
	velocity = move_and_slide(velocity)
	
	if velocity.y > 0:
		$AnimationPlayer.play("move_down")
	elif velocity.y < 0:
		$AnimationPlayer.play("move_up")
	elif velocity.x > 0:
		$AnimationPlayer.play("move_horizontal")
		$Sprite.flip_h = true
	elif velocity.x < 0:
		$AnimationPlayer.play("move_horizontal")
		$Sprite.flip_h = false
	else:
		if last_velocity.y > 0:
			$AnimationPlayer.play("idle_down")
		elif last_velocity.y < 0:
			$AnimationPlayer.play("idle_up")
		elif last_velocity.x > 0:
			$Sprite.flip_h = true
			$AnimationPlayer.play("idle_horizontal")
		elif last_velocity.x < 0:
			$Sprite.flip_h = false
			$AnimationPlayer.play("idle_horizontal")
	
	if last_velocity != velocity:
		last_velocity = velocity


func toggle_flashlight():
	$Flashlight.enabled = not $Flashlight.enabled


func _on_WanderTimer_timeout():
	randomise_direction()


func _on_NPC_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		# Sets tile based on placement range
		if player.is_within_position_reach(get_global_mouse_position()):
			var conversation_name
			
			if not met_player:
				conversation_name = "meeting"
				met_player = true
			else:
				conversation_name = "generic"
			
			player.get_node("HUD/DialogueBox").load_conversation(npc_name, conversation_name)
