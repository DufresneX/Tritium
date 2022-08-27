extends StaticBody2D

var entry = false

func _ready():
	$AnimatedSprite.play("Powering off")
	$CollisionShape2D.set_deferred("disabled", false)

func _on_Area2D_body_entered(_body):
	entry = true
	$AnimatedSprite.play("Powering off")

func _on_Area2D_body_exited(_body):
	entry = false
	
	$AnimatedSprite.play("Powering off", true)
	$CollisionShape2D.set_deferred("disabled", false)

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.playing = false
	
	if entry == true:
		$AnimatedSprite.play("Off")
		$CollisionShape2D.set_deferred("disabled", true)
	
	else:
		$AnimatedSprite.play("On")
