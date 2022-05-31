extends Area2D

func _on_Falzone_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://DeathScreen.tscn")
