extends KinematicBody2D

var velocity = Vector2 (0,0)
var direction = 0
	

		

func _physics_process(delta):
	
	if velocity.x == 500:
		$AnimatedSprite.flip_h = false
		print(direction)
	elif velocity.x == -500:
		$AnimatedSprite.flip_h = true
	print(direction)
	
	move_and_slide(velocity,Vector2.ZERO)
	
	
