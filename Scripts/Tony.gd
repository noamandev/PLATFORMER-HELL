extends Area2D
#Some variables
var CHAR_READ_RATE = 0.0005
var queue_text = -1
var friendship_exp = 0
var reset_point = 6
# Text
var dialogue_text = ["Howdy mate! How ya been doin'?",
					"I guess we both are the shortest here",
					"but man, they should clean this place... Oh wait, it's a prison.",
					"I really don't know why they sell alcohol here.",
					"kind of a scuffed prison, like this game your playing.",
					"Oh yeah, I don't exist. I'm programmed to say this stuff.",
					"kinda sad the more you think about it."]

func _input(event):
	if event.is_action_pressed("next_text") and get_overlapping_bodies().size() > 2:
		friendship_exp += 0.125
		GlobalScript.socializationXP += 2
		$Dialogue_Box.visible = true
		if friendship_exp > 2:
			dialogue_text = ["I seee we're getting along quit well",
							"I heard that you're trying to escape from this prison",
							"That's quite a daunting task... You need bravery and SKILL",
							"Oh yeah! I almosst forgot!",
							"You need skill in order to SMASH out of this prison!",
							"There's a guy outside ( in the playing area ) called Kung Huang",
							"He's suprisingly good at martial arts.",
							"He'll definitely train you! He charges 2 coins for a lesson",
							"Some how he managed to get a hold a baseball bat",
							"He charges 10 coins for it, That will help you in defeating...",
							"The final boss.....",
							"You: The final BOSS?!",
							"Him, even the gaurds themselves are scared of him!",
							"You NEED DETERMINATION!! and BE DETERMINED!!",
							"I BELIEVE IN YOU!"]
			reset_point = 14
	if event.is_action_pressed("next_text") and get_overlapping_bodies().size() > 2:
		queue_text += 1
		print(queue_text)
		GlobalScript.queue_text($Dialogue_Box, dialogue_text, queue_text, 0.05, reset_point + 1)
		if queue_text > reset_point:
			queue_text = -1


func _on_Tony_body_exited(body):
	$Dialogue_Box.visible = false
	queue_text = -1
