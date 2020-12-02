extends Actor


# Settings
const PLACEMENT_TILE_RANGE = 2

var walk_speed = 200
var run_speed = 400


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.is_action_pressed("toggle_light"):
				$Flashlight.enabled = not $Flashlight.enabled


# Called every physics tick.
func _physics_process(_delta):
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		
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


func is_within_tile_reach(tile_position, player_tile_position):
	return abs(tile_position.x - player_tile_position.x) <= PLACEMENT_TILE_RANGE and abs(tile_position.y - player_tile_position.y) <= PLACEMENT_TILE_RANGE


func is_within_position_reach(mouse_position):
	return abs(global_position.x - mouse_position.x) <= PLACEMENT_TILE_RANGE * 16 and abs(global_position.y - mouse_position.y) <= PLACEMENT_TILE_RANGE * 16


func take_damage(amount):
	.take_damage(amount)
	set_health_bar(health)
	
	
func use_stamina(amount):
	var can_act = .use_stamina(amount)
	set_stamina_bar(stamina)
	
	return can_act


func die():
	var _error = get_tree().change_scene("res://gui/menus/TitleScreen.tscn")


func set_health_bar(value):
	$HUD/StatusBars.health_bar.value = value


func set_stamina_bar(value):
	$HUD/StatusBars.stamina_bar.value = value


func set_fear_bar(value):
	$HUD/StatusBars.fear_bar.value = value
