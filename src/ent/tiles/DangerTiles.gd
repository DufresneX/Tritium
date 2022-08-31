extends TileMap

func _physics_process(_delta):
	$AnimationPlayer.play("Lava")
