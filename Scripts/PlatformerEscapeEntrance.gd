extends Area2D

func _on_Escape2D_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://PlatformerEscape.tscn")
