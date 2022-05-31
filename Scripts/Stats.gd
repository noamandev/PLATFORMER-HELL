extends Label

func _physics_process(delta):
	$coins_stat.text = "Coins collected: " + str(GlobalScript.coins)
	$goons_stat.text = "Goons killed: " + str(GlobalScript.goons_killed)
	$npc_stat.text =  "Socialization level: " + str(GlobalScript.socializationXP)
