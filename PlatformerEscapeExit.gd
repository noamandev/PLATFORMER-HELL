extends Area2D

func _on_Exit_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://The Outside World.tscn")
