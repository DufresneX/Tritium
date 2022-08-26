extends Button

export var level = preload("res://Assets/Levels/Level 1.tscn")


func _on_Button_pressed():
	get_tree().change_scene_to(level)
