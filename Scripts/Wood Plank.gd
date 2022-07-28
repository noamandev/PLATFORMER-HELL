extends Particles2D

signal woodPlankExplode
signal woodSpriteHide

func woodPlankExplode():
	$StaticBody2D/CollisionShape2D.disabled = true
	$".".emitting = true
	$Sprite.hide()
	emit_signal("woodPlankExplode")
# explosion functionallity!
func explode():
	woodPlankExplode()
	yield(self, "woodPlankExplode")
	queue_free()
