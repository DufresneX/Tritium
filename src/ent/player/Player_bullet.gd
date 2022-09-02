extends KinematicBody2D

export var charge_level = 1

var velocity = Vector2.ZERO
var direction = 0


func _physics_process(_delta):
	if velocity.x == 500:
		$AnimatedSprite.flip_h = false

	elif velocity.x == -500:
		$AnimatedSprite.flip_h = true
	
	var _velocity = move_and_slide(velocity, Vector2.ZERO)
	



func _on_Area2D_body_entered(_body):
	if _body.name == "Enemy_2":
		
		print("Wop")
		_body._ouch(charge_level * 5)
		queue_free()
	
	else:
		print("Foop")
		queue_free()
	
