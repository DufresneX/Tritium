extends Control

export var level =  preload("res://scn/lvl/Level 1.tscn")
export var x = 250

func _process(_delta):
	$ColorRect2.color = x
	
	if x >= 2:
		x -= 1

func _on_Button_pressed():
	get_tree().change_scene_to(level)
