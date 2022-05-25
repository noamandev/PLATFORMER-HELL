extends Area2D

signal exploded

func _on_Explosive_Barrel__body_entered(body):
	if (body.name == "Player"):
		$AnimatedSprite.play("explosion")
		emit_signal("exploded")
		$CollisionShape2D.queue_free()
