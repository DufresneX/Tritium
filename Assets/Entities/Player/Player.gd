extends KinematicBody2D

const GRAVITY = 30
const JUMP_HIGHT = -500
var velocity = Vector2 (0, 0)
var max_speed = 100
var hp = 10
var lives = 3
var slipperyness = 2
var max_hp
var dir = 1
var hptank_parts = 0

func _physics_process(delta): 

	if Input.is_action_pressed("Right"):
		dir = -300
		if velocity.x < max_speed + 1:
			velocity.x = velocity.x + max_speed / (slipperyness / 2)
		else:
			 velocity.x = max_speed
	elif Input.is_action_pressed("Left"):
		dir = 300
		if velocity.x > - max_speed - 1:
			velocity.x = velocity.x - max_speed / (slipperyness / 2)
		else:
			velocity.x = - max_speed
	else:
		if velocity.x > 0:
			velocity.x = velocity.x - max_speed / slipperyness
			if velocity.x < 0:
				velocity.x = 0
		elif velocity.x < 0:
			velocity.x = velocity.x + max_speed / slipperyness
			if velocity.x > 0:
				velocity.x = 0
	
	if Input.is_action_just_pressed("Up") and is_on_floor() or Input.is_action_just_pressed("Up") and is_on_wall():
		velocity.y = JUMP_HIGHT
		if Input.is_action_just_pressed("Up") and is_on_wall() and not is_on_floor():
			velocity.x = dir + dir
	
	velocity.y = velocity.y + GRAVITY
	
	velocity = move_and_slide(velocity,Vector2.UP)
	
	
