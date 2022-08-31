extends KinematicBody2D

var coins = 0
var velocity = Vector2(0,0)
const SPEED = 180
const JUMP_FORCE = -900
const GRAVITY = 30
var lives = 3

signal life_lost
signal life_gained

func _physics_process(_delta):
	if Input.is_action_pressed("Right"):
		velocity.x = SPEED
		
		$Sprite.play("Walk")
		$Sprite.flip_h = false
	
	elif Input.is_action_pressed("Left"):
		velocity.x = -SPEED
		
		$Sprite.play("Walk")
		$Sprite.flip_h = true
	
	else:
		$Sprite.play("Idle")
		
	if not is_on_floor():
		$Sprite.play("Air")
	
	velocity.y = velocity.y + GRAVITY
	
	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y = JUMP_FORCE
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x, 0, 0.2)

func _on_Fall_zone_body_entered(_body):
	get_tree().change_scene("res://Menus/GameOver.tscn")

func bounce():
	velocity.y = JUMP_FORCE * 0.75

func ouch(var EnemyPosX):
	$LoseLife.play()
	lives = lives - 1
	emit_signal("life_lost")
	
	velocity.y = JUMP_FORCE * 0.5
	
	if position.x < EnemyPosX:
		velocity.x = -800
	
	elif position.x > EnemyPosX:
		velocity.x = 800
	
	Input.action_release("Left")
	Input.action_release("Right")
	
	if lives == 0:
		set_modulate(Color(1, 0.3, 0.3, 0.45))
	
	$Timer.start()

func _on_Timer_timeout():
	if lives == 0:
		get_tree().change_scene("res://Menus/GameOver.tscn")

func spring():
	velocity.y = JUMP_FORCE * 1.25

func _on_1up_OneUp():
	lives = lives + 1
	emit_signal("life_gained")

func BigBounce():
	velocity.y = JUMP_FORCE * 1.0
