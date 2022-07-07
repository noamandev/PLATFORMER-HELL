extends Area2D

var CHAR_READ_RATE = 0.0005
var queue_text = -1
# Text
var dialogue_text = ["Hello. Im the Janitor", 
		   "Im severly underpaid and depressed :D!",
		   "Guess saying it to a random guy won't just fix it.",
		   "*sigh* guess I will go back to cleaning..."]

func _input(event):
	if event.is_action_pressed("next_text") and get_overlapping_bodies().size() > 0:
		GlobalScript.socializationXP += 1.5
		$Dialogue_Box.visible = true
	if event.is_action_pressed("next_text") and get_overlapping_bodies().size() > 0:
		queue_text += 1
		GlobalScript.queue_text($Dialogue_Box, dialogue_text, queue_text, 0.05, 4)
		if queue_text > 3:
			queue_text = -1


func _on_TheDepressedJanitor_body_exited(body):
	$Dialogue_Box.visible = false
	queue_text = -1
