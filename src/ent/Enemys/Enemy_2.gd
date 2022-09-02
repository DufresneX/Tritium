extends KinematicBody2D


export var hp = 25
export var strength = 5
export var dir = 1

var playerinrange = false

func _physics_process(_delta):
	
	if dir == 1:
		$AnimatedSprite.flip_h = false
		$"Line of sight".rotation_degrees = -90
	else:
		$AnimatedSprite.flip_h = true 
		$"Line of sight".rotation_degrees = 90
	
	
	if playerinrange == true and !$"Line of sight".is_colliding():
		
		if get_parent().get_node("Player").position.x > position.x:
			dir = -1
		else:
			dir = 1

func _ouch(damage):
	hp -= damage
	
	if get_parent().get_node("Player").position.x > position.x:
		dir = -1
	else:
		dir = 1
	
	
	if hp <= 0:
		queue_free()

