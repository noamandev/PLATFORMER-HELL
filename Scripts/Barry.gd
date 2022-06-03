extends Area2D
#Some variables
var CHAR_READ_RATE = 0.0005
var queue_text = -1

# Text
var dialogue_text = ["*cough* Hello? Who are you and why are you here?", 
		   "*cough* I MUST TELL PEOPLE *deep inhale*",
		   "TO NOT JUDGE PEOPLE BY THEIR LOOOKSS!!!!",
		   "( You: That was random...and loud. )",
		   "Oh yeah, Have you seen that chef?",
		   "Yeah, he LOOKS so DUMB!",
		   "He probably IS DUMB!",
		   "Now get out of my way! I need more alcohol :D!"]
		
func _input(event):
	if event.is_action_pressed("next_text") and get_overlapping_bodies().size() > 2:
		GlobalScript.socializationXP += 1
		$Dialogue_Box.visible = true
	if event.is_action_pressed("next_text") and get_overlapping_bodies().size() > 2:
		queue_text += 1
		print(queue_text)
		GlobalScript.queue_text($Dialogue_Box, dialogue_text, queue_text, 0.05, 8)
		if queue_text > 7:
			queue_text = -1


func _on_Barry_body_exited(body):
	$Dialogue_Box.visible = false
	queue_text = -1
