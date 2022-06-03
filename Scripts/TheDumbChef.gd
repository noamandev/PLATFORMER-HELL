extends Area2D
#Some variables
var CHAR_READ_RATE = 0.0005
var queue_text = -1
var STATE = false
# Text
var dialogue_text = ["Hi, I'm Albert. Or better known as 'The Dumb Chef'", 
		   "That's because of my weird eye placement of my weird eye placement.",
		   "Hopfully you don't mock me,",
		   "and hopefully you're nice..."]

func _input(event):
	if event.is_action_pressed("next_text") and get_overlapping_bodies().size() > 2:
		GlobalScript.socializationXP += 1.5
		$Dialogue_Box.visible = true
	if event.is_action_pressed("next_text") and get_overlapping_bodies().size() > 2:
		queue_text += 1
		print(queue_text)
		GlobalScript.queue_text($Dialogue_Box, dialogue_text, queue_text, 0.05, 4)
		if queue_text > 3:
			queue_text = -1


func _on_TheDumbChef_body_exited(body):
	$Dialogue_Box.visible = false
	queue_text = -1
