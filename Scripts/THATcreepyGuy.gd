extends Area2D

var CHAR_READ_RATE = 0.0005
var queue_text = -1

# Text
var dialogue_text = ["So you're the one that Tony sent me to train", 
		   "Right? Well.... A noodle like you...",
		   "won't be able to escape out of this prison.",
		   "First, let's do basic wall jumps",
		   "First, hug a wall. Jump, get off of it.",
		"And then immediately thrush upward ( press W )",
		"And get back on it",
		"( press D or A, depends on what wall you're climbing )."
		]
# A bunch of function!!!		

func _input(event):
	if event.is_action_pressed("next_text") and get_overlapping_bodies().size() > 1:
		GlobalScript.socializationXP += 1
		$Dialogue_Box.visible = true
	if event.is_action_pressed("next_text") and get_overlapping_bodies().size() > 1:
		queue_text += 1
		GlobalScript.queue_text($Dialogue_Box, dialogue_text, queue_text, 0.05, 8)
		if queue_text > 7:
			queue_text = -1

func _on_THATcreepyGuy_body_exited(body):
	$Dialogue_Box.visible = false
	queue_text = -1
