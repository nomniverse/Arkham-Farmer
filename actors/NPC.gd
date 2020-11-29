extends Actor


# Declare member variables here. Examples:
var walk_speed = 200
var run_speed = 400


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process(delta):
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
