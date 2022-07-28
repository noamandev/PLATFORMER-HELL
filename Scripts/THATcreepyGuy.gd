extends Area2D
signal first_meet
signal wall_jump_complete

var CHAR_READ_RATE = 0.0005
var queue_text = -1
var friendship_exp : int = 0
var reset_point : int = 10
# Text
var dialogue_text : Array
# A bunch of function!!!		

func _process(delta):
	# code for learning wall jumps text
	if GlobalScript.didCollectCoin == false:
		dialogue_text = ["So you're the one that Tony sent me to train", 
		   "Right? Well.... A noodle like you...",
		   "won't be able to escape out of this prison.",
		   "First, let's do basic wall jumps",
		   "( Tutorial: JUMP on to a wall ( not 'hug' )",
		", Then hold the jump button ( W )",
		", Then hold the OPPOSITE direction button",
		", Example, If you're wall-jumping a wall to your right",
		", You hold W and hold A ( A is Left, D is right )",
		", Therefore 'the opposite direction key' )",
		"If you walk to the opposite side, you will see a coin, get it..."
		]
	#code for battle text
	if GlobalScript.didCollectCoin == true and GlobalScript.didDoFirstBattle == false:
		dialogue_text = [
				"Good Good",
				"Now... Let's get you well versed in battle",
				"For this, we can just duke it out in a 1v1",
				"Don't worry I will go easy on you :)",
				"I will teach you moves on the way"
			]
		reset_point = 4
	#code for escaping
	if GlobalScript.didCollectCoin == true and GlobalScript.didDoFirstBattle == true:
		dialogue_text = [
				"Hm. You actually beat me? Well...",
				"Since I thought you 3 attacks..",
				"I think you should be ( a little ) good",
				"So, See that little exit behind me?",
				"I've ALSO been working on getting out",
				"I've made a little parkour course.",
				"And with it, You can get out.",
				"But the gaurds will be expecting YOU",
				"So Compadre, good luck ;D...",
				"...",
				"Oh yeah, lesson fee is 5 coins ;D!",
				"Mmmm, thank you very much :D!"
			]
		reset_point = 9 + 2

func _input(event):
	if event.is_action_pressed("next_text") and get_overlapping_bodies().size() >= 1:
		GlobalScript.socializationXP += 1
		$Dialogue_Box.visible = true
	if event.is_action_pressed("next_text") and get_overlapping_bodies().size() >= 1:
		queue_text += 1
		GlobalScript.queue_text($Dialogue_Box, dialogue_text, queue_text, 0.05, reset_point + 1)
		if queue_text > reset_point:
			queue_text = -1
			if friendship_exp == 1:
				return
			elif GlobalScript.didCollectCoin == true and GlobalScript.didDoFirstBattle == true:
				get_tree().call_group("WoodPlanks", "explode")
				friendship_exp = 1
			elif GlobalScript.didCollectCoin == true and GlobalScript.didDoFirstBattle == false:
				get_tree().change_scene("res://Mini-Boss-Battle.tscn")

func _on_THATcreepyGuy_body_exited(body):
	$Dialogue_Box.visible = false
	queue_text = -1

func _on_COIN_coin_collected():
	GlobalScript.didCollectCoin = true
