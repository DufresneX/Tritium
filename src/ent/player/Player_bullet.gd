extends KinematicBody2D

var velocity = Vector2.ZERO
var direction = 0

func _physics_process(_delta):
	if velocity.x == 500:
		$AnimatedSprite.flip_h = false

	elif velocity.x == -500:
		$AnimatedSprite.flip_h = true
	
	var _velocity = move_and_slide(velocity, Vector2.ZERO)
