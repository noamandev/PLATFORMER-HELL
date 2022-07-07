extends Area2D

var CHAR_READ_RATE = 0.0005
var queue_text = -1

# Text
var dialogue_text = ["FOOTBALL FOOTBALL", 
		   "LET'S GO FOOTBALL..."]
# A bunch of function!!!		

func _input(event):
	if event.is_action_pressed("next_text") and get_overlapping_bodies().size() > 1:
		GlobalScript.socializationXP += 1
		$Dialogue_Box.visible = true
	if event.is_action_pressed("next_text") and get_overlapping_bodies().size() > 1:
		queue_text += 1
		GlobalScript.queue_text($Dialogue_Box, dialogue_text, queue_text, 0.05, 2)
		if queue_text > 1:
			queue_text = -1


func _on_Football_couch_body_entered(body):
	$Dialogue_Box.visible = false
	queue_text = -1
