extends KinematicBody2D

export var GRAVITY = 30
export var JUMP_HEIGHT = -650

export var slipperyness = 2
export var hp = 100

export var bullet = preload("res://scn/ent/player/Player_bullet.tscn")

var saving = 0
var velocity = Vector2 (0, 0)
var max_speed = 100
var lives = 2

var max_hp = 100
var hptank_parts = 0

var saveX = 93
var saveY = 3

var in_lava = 0
var dir = 1
var jumping = false

var weapon_mode = "rapid"
var bullet_timer = 0
var recharge_time = 0.5
var charge_level = 0
var max_charge_level = 2

signal hpChange
signal lifeChange
signal died
signal shoot(x, y, dir)

func _ready():
	$Anim_Parts/Body.play("Beam in", true)
	$Anim_Parts/Head.play("Beam in", true)
	$Anim_Parts/Left_Arm.play("Beam in", true)
	$Anim_Parts/Left_leg.play("Beam in", true)
	$Anim_Parts/Right_arm.play("Beam in", true)
	$Anim_Parts/Right_leg.play("Beam in", true)

func _physics_process(_delta):
	if Input.is_action_pressed("Right"):
		if saving == 0:
			dir = -500
			
			$Anim_Parts/Body.flip_h = true
			$Anim_Parts/Head.flip_h = true
			$Anim_Parts/Left_Arm.flip_h = true
			$Anim_Parts/Left_leg.flip_h = true
			$Anim_Parts/Right_arm.flip_h = true
			$Anim_Parts/Right_leg.flip_h = true
			
			$Anim_Parts/Spark_anim.offset.x = 27
			$Anim_Parts/Spark_anim.flip_h = false
			
			if velocity.x < max_speed + 1:
				velocity.x = velocity.x + max_speed / (slipperyness / 2)
			
			else:
				 velocity.x = max_speed
	
	elif Input.is_action_pressed("Left"):
		if saving == 0:
			dir = 500
			
			$Anim_Parts/Body.flip_h = false
			$Anim_Parts/Head.flip_h = false
			$Anim_Parts/Left_Arm.flip_h = false
			$Anim_Parts/Left_leg.flip_h = false
			$Anim_Parts/Right_arm.flip_h = false
			$Anim_Parts/Right_leg.flip_h = false
			
			$Anim_Parts/Spark_anim.offset.x = -27
			$Anim_Parts/Spark_anim.flip_h = true
			
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

	# Animations
	# ----------
	
	# Face camera
	if saving == 1:
		$Anim_Parts/Body.play("Face forward")
		$Anim_Parts/Head.play("Face forward")
		
		if not Input.is_action_pressed("Shoot"):
			$Anim_Parts/Left_Arm.play("Face forward")
		
		$Anim_Parts/Left_leg.play("Face forward")
		$Anim_Parts/Right_arm.play("Face forward")
		$Anim_Parts/Right_leg.play("Face forward")
	
	# Run
	elif Input.is_action_pressed("Left") and is_on_floor() or Input.is_action_pressed("Right") and is_on_floor():
		$Anim_Parts/Right_leg.play("Run")
		$Anim_Parts/Right_arm.play("Run")
		$Anim_Parts/Left_leg.play("Run")
		
		if !Input.is_action_pressed("Shoot"):
			$Anim_Parts/Left_Arm.play("Run")
	
	#Jump
	elif !is_on_floor() and !is_on_wall():
		$Anim_Parts/Right_leg.play("Jump")
		$Anim_Parts/Right_arm.play("Jump")
		$Anim_Parts/Left_leg.play("Jump")
		
		if !Input.is_action_pressed("Shoot"):
			$Anim_Parts/Left_Arm.play("Jump")
	
	else:
		$Anim_Parts/Body.play("Idle")
		$Anim_Parts/Head.play("Idle")
		$Anim_Parts/Right_leg.play("Idle")
		$Anim_Parts/Right_arm.play("Idle")
		$Anim_Parts/Left_leg.play("Idle")
		if not Input.is_action_pressed("Shoot"):
			$Anim_Parts/Left_Arm.play("Idle")
		
		# Make the head head and body face in the right direction while wall jumping
		if dir == -500:
			$Anim_Parts/Body.flip_h = true
			$Anim_Parts/Head.flip_h = true
		
		elif dir == 500:
			$Anim_Parts/Body.flip_h = false
			$Anim_Parts/Head.flip_h = false

	# Jump animation / Up movement
	if Input.is_action_just_pressed("Up") and is_on_floor() or Input.is_action_just_pressed("Up") and is_on_wall():
		if saving == 0: velocity.y = JUMP_HEIGHT
		
		# Wall jump
		
		if Input.is_action_just_pressed("Up") and is_on_wall() and !is_on_floor():
			velocity.x = dir
	
	if is_on_wall() and !is_on_floor() and !Input.is_action_just_pressed("Up"):
		velocity.y = 70
		
		$Anim_Parts/Spark_anim.play("Spark")
		$Anim_Parts/Body.play("Wall slide")
		$Anim_Parts/Head.play("Wall slide")
		$Anim_Parts/Left_Arm.play("Wall slide")
		$Anim_Parts/Left_leg.play("Wall slide")
		$Anim_Parts/Right_arm.play("Wall slide")
		$Anim_Parts/Right_leg.play("Wall slide")
	
	else:
		$Anim_Parts/Spark_anim.play("Idle")

	# Shoot
	if Input.is_action_pressed("Shoot"):
		emit_signal("shoot", position.x, position.y, dir)
		$Anim_Parts/Left_Arm.play("Shoot")
		shoot()

	emit_signal("hpChange", hp)
	emit_signal("lifeChange", lives)
	
	# Check if in lava
	if in_lava == 1: 
		hp -= 0.25
		velocity.y = velocity.y / 1.5
		
		if not velocity.x == 0:
			velocity.x = velocity.x / 4
		else:
			velocity.x = 10
	
	if hp < 0.5:
		if lives > 0:
			emit_signal("died")
			lives -= 1
			
			position.x = saveX
			position.y = saveY
			hp = 100
		
		else:
			var check_err = get_tree().change_scene("res://Game over.tscn")
			
			if check_err != 0:
				print("An ERROR occured while changing scenes to \"res://Game over.tscn\" in Player.gd: ", check_err)
	
	velocity.y = velocity.y + GRAVITY

	velocity = move_and_slide(velocity,Vector2.UP)

func _on_Area2D_body_entered(_body):
	if lives > 0:
		hp = 0
	
	else:
		var check_err = get_tree().change_scene("res://Game over.tscn")
		
		if check_err != 0:
			print("An ERROR occured while changing scenes to \"res://Game over.tscn\" in Player.gd: ", check_err)

func _on_Danger_checker_body_entered(_body):
	in_lava = 1

func _on_Danger_checker_body_exited(_body):
	in_lava = 0

func _on_Fluid_checker_body_entered(_body):
	velocity.y = 5000

func _on_Savepoint_save(X, Y):
	saveX = X
	saveY = Y
	
	position.x = X
	position.y = Y
	
	$Timer.start()
	
func _on_Timer_timeout():
	saving = 0

func _on_No_save_button_up():
	saving = 0

func _on_Savepoint_prep_for_save(X, Y):
	saving = 1
	velocity.x = 0
	velocity.y = 0
	
	position.x = X
	position.y = Y

func shoot():
	if bullet_timer == 0 and saving == 0:
		bullet_timer = 1
		
		if Input.is_action_just_released("Shoot") or weapon_mode == "rapid":
			var pb = bullet.instance()
			
			get_parent().add_child(pb)
			
			pb.position.x = position.x - (dir/50)
			pb.position.y = position.y - 10
			
			pb.velocity.x = - dir
			
			if weapon_mode == "rapid":
				$Bullet_shot.start(recharge_time)
			
			elif weapon_mode == "charge":
				$Bullet_charge.start(1)

func _on_Bullet_shot_timeout():
	bullet_timer = 0

func _on_Bullet_charge_timeout():
	bullet_timer = 0
	
	if charge_level < max_charge_level:
		charge_level += 1
