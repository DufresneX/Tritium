extends Button

export var level = preload("res://Assets/Levels/Level 1.tscn")

func _on_Button_pressed():
	var check_err  = get_tree().change_scene_to(level)
	
	if check_err != 0:
		print("An ERROR occured while changing scenes to ", level.resource_path, " in PlayButton.gd: ", check_err)
