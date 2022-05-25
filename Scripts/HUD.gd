extends Node2D
# Coin script ( d'know how to explain this LMAO )
func _ready():
	$CoinCounter.text = String(GlobalScript.coins)

#func _physics_process(delta):
	#f GlobalScript.coins == 6:
		#get_tree().reload_current_scene()

func _on_COIN_coin_collected():
	GlobalScript.coins = GlobalScript.coins + 1
	_ready()
