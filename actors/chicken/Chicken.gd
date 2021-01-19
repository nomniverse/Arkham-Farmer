extends Actor


# Declare member variables here. Examples:
var walk_speed = 100
var run_speed = 200

var is_eating = false


# Preloaded scenes
var pickup = preload("res://items/Pickup.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	var error = get_tree().get_root().get_node("Game/TimeCycle").connect("day_changed", self, "_on_day_changed")
	
	if error:
		print("Connect failed...")
	
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# Called every physics tick.
func _physics_process(_delta):
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


func _on_EatTimer_timeout():
	is_eating = true
	
	$AnimationPlayer.play("eat")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "eat":
		is_eating = false


func _on_DirectionTimer_timeout():
	randomise_direction()


func _on_day_changed(_day):
	var new_egg = pickup.instance()
	new_egg.position = position
	new_egg.set_item(Items.EGG)
	get_parent().add_child(new_egg)
