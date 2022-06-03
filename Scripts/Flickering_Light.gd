extends Node2D

func _ready():
	flicker_light()
	print('HEY')
	
func flicker_light():
	
	$Tween.interpolate_property($Light2D, "Energy", 0.3, 0.8, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
