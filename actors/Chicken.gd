extends KinematicBody2D


# Declare member variables here. Examples:
var walk_speed = 100
var run_speed = 200

var velocity = Vector2.ZERO
var last_velocity = Vector2()

var is_eating = false

var rng = RandomNumberGenerator.new()

# Preloaded scenes
var egg = preload("res://items/Egg.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().get_node("Game/TimeCycle").connect("day_changed", self, "_on_day_changed")
	
	rng.randomize()
	
	
func randomise_direction():
	velocity.y = rng.randi_range(-1, 1)
	velocity.x = rng.randi_range(-1, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# Called every physics tick.
func _physics_process(_delta):
#	velocity = Vector2.ZERO
#
#	if not is_eating:
#		if Input.is_action_pressed("move_up"):
#			velocity.y -= 1
#
#		if Input.is_action_pressed("move_down"):
#			velocity.y += 1
#
#		if Input.is_action_pressed("move_left"):
#			velocity.x -= 1
#
#		if Input.is_action_pressed("move_right"):
#			velocity.x += 1
			
	
	
	if not is_eating:
		velocity = velocity.normalized() * walk_speed
		velocity = move_and_slide(velocity)
		
		if velocity.y == 0 and velocity.x == 0:
			$AnimationPlayer.play("idle")
		else:
			$AnimationPlayer.play("walk")
				
			if velocity.x > 0:
				$Sprite.flip_h = false
			elif velocity.x < 0:
				$Sprite.flip_h = true
		
	
	if last_velocity != velocity:
		last_velocity = velocity


func _on_EatTimer_timeout():
	is_eating = true
	
	$AnimationPlayer.play("eat")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "eat":
		is_eating = false


func _on_DirectionTimer_timeout():
	randomise_direction()


func _on_day_changed(_day):
	var new_egg = egg.instance()
	new_egg.position = position
	get_parent().add_child(new_egg)
