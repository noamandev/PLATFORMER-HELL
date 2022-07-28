extends Area2D

func _on_spikes_trap_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://DeathScreen.tscn")
