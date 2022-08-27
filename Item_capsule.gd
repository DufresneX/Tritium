extends StaticBody2D

var x = 0
var y = 0

func _ready():
	$AnimatedSprite.play("Active")

func _on_Area2D_body_entered(_body):
	$AnimatedSprite.play("Generate_item")

func _on_AnimatedSprite_frame_changed():
	if $AnimatedSprite.frame == 119:
		$AnimatedSprite.playing = false
		
		y = 0
		$Timer.start(0.1)

func _on_Timer_timeout():
	if x == 12 or y == 1:
		y = 1
		
		if x == 1:
			$AnimatedSprite.modulate = Color(1, 1, 1, 1)
			$AnimatedSprite.frame = 1
			
			$CollisionShape2D2.disabled = true
			$Area2D/CollisionShape2D.disabled = true
		
		else:
			$Timer.start(0.1)
			
			x -= 1
			$AnimatedSprite.modulate = Color(x, x, x, 255)
	else:
		x += 1
		
		$Timer.start(0.1)
		$AnimatedSprite.modulate = Color(x, x, x, 255)
