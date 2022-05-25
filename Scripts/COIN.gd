extends Area2D

signal coin_collected

func _on_COIN_body_entered(_body):
	queue_free()
	emit_signal("coin_collected")
	
