extends Node2D


# Declare member variables here. Examples:
var wielder


# Called when the node enters the scene tree for the first time.
func _ready():
	wielder = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func shoot():
	$BulletRayCast2D.rotation = get_angle_to(get_global_mouse_position())
	$BulletRayCast2D.enabled = true
	$BulletRayCast2D.force_raycast_update()
	
	var points = PoolVector2Array()
	points.append(Vector2(0, 0))
	
	if $BulletRayCast2D.is_colliding() and $BulletRayCast2D.get_collider() != wielder:
		points.append(to_local($BulletRayCast2D.get_collision_point()))
		
		if $BulletRayCast2D.get_collider().has_method("take_damage"):
			$BulletRayCast2D.get_collider().take_damage(50)
	else:
		points.append($BulletRayCast2D.cast_to.rotated(get_angle_to(get_global_mouse_position())))
		
	$BulletTrace.points = points
	$BulletTraceTimer.start()
		
	$BulletRayCast2D.enabled = false


func _on_BulletTraceTimer_timeout():
	$BulletTrace.clear_points()
