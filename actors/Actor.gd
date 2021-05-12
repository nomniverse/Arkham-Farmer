extends KinematicBody2D


class_name Actor


# Signals
signal death


# Class member variables
var health = 100
var stamina = 100
var fear = 0

var money = 0


var rng = RandomNumberGenerator.new()

var velocity = Vector2.ZERO
var last_velocity = Vector2()


func take_damage(amount):
	health -= amount
	
	if health <= 0:
		emit_signal("death")
		die()


func use_stamina(amount):
	stamina -= amount
	
	if stamina < 0:
		stamina = 0
		return false
		
	return true


# Called when the actor dies. By default, it will just remove the actor from the game.
func die():
	self.queue_free()


func randomise_direction():
	velocity.y = rng.randi_range(-1, 1)
	velocity.x = rng.randi_range(-1, 1)
