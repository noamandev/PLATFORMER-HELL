extends Area2D
#Some variables
var CHAR_READ_RATE = 0.0005
var queue_text = -1

# Text
var dialogue_text = ["Hi how are you?", 
		   "Make sure you go back to your jail sell",
		   "Or boss will be mad at me :("]
# A bunch of function!!!		

func _input(event):
	if event.is_action_pressed("next_text") and get_overlapping_bodies().size() > 0:
		GlobalScript.socializationXP += 1
		$Dialogue_Box.visible = true
	if event.is_action_pressed("next_text") and get_overlapping_bodies().size() > 0:
		queue_text += 1
		print(queue_text)
		GlobalScript.queue_text($Dialogue_Box, dialogue_text, queue_text, 0.05, 3)
		if queue_text > 2:
			queue_text = -1

func _on_Gaurd_Steven_body_exited(body):
	$Dialogue_Box.visible = false
	queue_text = -1
