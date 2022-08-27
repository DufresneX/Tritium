extends CanvasLayer

func _on_Player_hpChange(hp):
	$Hp.text = str(round(hp))

func _on_Player_lifeChange(lives):
	$SpareReactors.text = str(round(lives))
