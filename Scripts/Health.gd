extends Node2D
# Health, I guess
func _ready():
	$Label.text = String(GlobalScript.health)

func _on_Explosive_Barrel__exploded():
	GlobalScript.health = GlobalScript.health - 2
	_ready()
	
	if GlobalScript.health == 0:
		get_tree().change_scene("res://Sitting_Room.tscn")
