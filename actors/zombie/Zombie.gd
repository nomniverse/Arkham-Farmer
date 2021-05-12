extends Actor


# Declare member variables here. Examples:
var walk_speed = 75
var run_speed = 150

var melee_damage = 10
var melee_target = null

var path
var chase_target = null


# Object instances
var farm
var player


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_root().get_node("Game/Player")
	farm = get_tree().get_root().get_node("Game/Farm")
	
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process(_delta):
	if chase_target:
		if not path:
			return
			
		var target_position = path[0]
		
		if position.distance_to(target_position) < 2:
			path.remove(0)
			
		velocity = (target_position - position).normalized() * run_speed
		
	else:
		velocity = velocity.normalized() * walk_speed
	
	velocity = move_and_slide(velocity)


func _on_PathTimer_timeout():
	if chase_target:
		path = farm.get_path_to_position(position, chase_target.position)


func _on_MeleeArea2D_body_entered(body):
	if body.has_method("take_damage"):
		if body == player:
			melee_target = body
			melee_target.take_damage(melee_damage)
			$MeleeTimer.start()


func _on_MeleeArea2D_body_exited(body):
	if body.has_method("take_damage"):
		if body == player:
			melee_target = null
			
			if not $MeleeTimer.is_stopped():
				$MeleeTimer.stop()


func _on_MeleeTimer_timeout():
	if melee_target:
		melee_target.take_damage(melee_damage)


func _on_DetectionArea2D_body_entered(body):
	if body == player:
		chase_target = body
		$PathTimer.start()
		
		if not $WanderTimer.is_stopped():
			$WanderTimer.stop()


func _on_DetectionArea2D_body_exited(body):
	if body == player:
		chase_target = null
		
		if not $PathTimer.is_stopped():
			$PathTimer.stop()
		
		$WanderTimer.start()


func _on_WanderTimer_timeout():
	randomise_direction()
