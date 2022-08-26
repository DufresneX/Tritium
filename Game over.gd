extends Control

var x = 250
export var level =  preload("res://Assets/Levels/Level 1.tscn")
# Called when the node enters the scene tree for the first time.
func _process(delta):
	$ColorRect2.color = x
	
	if x >= 2: x -= 1

func _on_Button_pressed():
	get_tree().change_scene_to(level)
