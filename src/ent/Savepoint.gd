extends StaticBody2D

var anim_frame = 0
var next_anim = 0
var no_button = 0 

var X
var Y

signal save
signal prep_for_save

func _ready():
	$Area2D.monitoring = true

func _physics_process(_delta):
	X = global_position.x
	Y = global_position.y

func _on_Area2D_body_entered(_body):
	emit_signal("prep_for_save", X, Y)
	
	$AnimatedSprite.play("Rise")
	$Timer.start()

func _on_Yes_save_button_up():
	emit_signal("save", X, Y)
	$CanvasLayer/Popup.hide()
	
	next_anim = 1
	$AnimatedSprite.play("Save")
	
func _on_No_save_button_up():
	$CanvasLayer/Popup.hide()
	$AnimatedSprite.play("Rise", true)
	
	next_anim = 2

func _on_AnimatedSprite_animation_finished():
	if next_anim == 2:
		$AnimatedSprite.playing = false
		$AnimatedSprite.play("Off")
		next_anim = 0

func _on_Timer_timeout():
	$CanvasLayer/Popup.popup_centered()

func _on_AnimatedSprite_frame_changed():
	if $AnimatedSprite.frame == 53 and next_anim != 2:
		$AnimatedSprite.playing = false
		anim_frame = 0
	
	elif next_anim == 1:
		if anim_frame == 20:
			anim_frame = 0
			$AnimatedSprite.playing = false
			$AnimatedSprite.play("Rise", true)
			next_anim = 2
		
		else:
			anim_frame += 1
	
	else:
		anim_frame +=1

func _on_Player_died():
	$Area2D.monitoring = false
	
	print("Disabled")

func _on_Player_gone_checker_body_exited(_body):
	$Area2D.monitoring = true
	
	print("Enabled")
