extends Control

export var screen = ""
export var text = """-$ Access Jupiter station observatory logs ETime Feb 14, 2589
3:04 Jupiter station observatory log 01.08.2589.3:04: Unidetentified 
celestial body detected 5 A.U.s from Jupiter station.

Danger level: Low

-$ Access Mars north observatory logs ETime Feb 28. 2589 
"""

var text_list = []
var x = 0

func _ready():
	$TextTimer.start(1)

func _text():
	$Label.text = text.left(x)
	print(text.length())
	screen = text.left(x)
	
	if x == 167:
		# TODO: Play animation scroll up
		pass
	
	else:
		$TextTimer.start(0.1)

func _on_TextTimer_timeout():
	x += 1
	
	_text()
