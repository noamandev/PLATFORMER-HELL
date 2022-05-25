extends Area2D
#Some variables
var CHAR_READ_RATE = 0.0005
var queue_text = -2
var STATE = false
# Text
var dialogue_text = ["Howdy mate! How ya been doin'?",
					"I'm assuming you met Barry, yeah, he's a bit much.",
					"I guess we both are the shortest here",
					"but man, they should clean this place.",
					"Oh wait, it's a prison.",
					"I really don't know why they sell alcohol here.",
					"kind of a scuffed prison, like this game your playing.",
					"Oh yeah, I don't exist. I'm programmed to say this stuff.",
					"kinda sad the more you think about it."]

func _on_Tony_body_entered(body):
	if body.name == 'Player':
		STATE = true


func _on_Tony_body_exited(body):
	if body.name == 'Player':
		STATE = false
		$Dialogue_Box.visible = false

func _input(event): 
	if STATE and event.is_action_pressed("ui_accept"):
		$Dialogue_Box.visible = true
	if STATE and event.is_action_pressed("exit_dialogue"):
		
		queue_text = queue_text + 1
		GlobalScript.queue_text($Dialogue_Box, dialogue_text, queue_text, 0.05, 9)
	if STATE == false:
		queue_text = -1
		$Dialogue_Box/Text.text = dialogue_text[0]
