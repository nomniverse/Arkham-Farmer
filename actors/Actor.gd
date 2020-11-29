extends KinematicBody2D


class_name Actor


# Signals
signal death


# Class member variables
var health = 100


var rng = RandomNumberGenerator.new()

var velocity = Vector2.ZERO
var last_velocity = Vector2()


func take_damage(amount):
	health -= amount
	print(health)
	
	if health <= 0:
		emit_signal("death")
		die()
		


# Called when the actor dies. By default, it will just remove the actor from the game.
func die():
	self.queue_free()


func randomise_direction():
	velocity.y = rng.randi_range(-1, 1)
	velocity.x = rng.randi_range(-1, 1)
