extends Area2D

var CHAR_READ_RATE = 0.0005
var queue_text = -2
var STATE = false
# Text
var dialogue_text = ["Hello. Im the Janitor", 
		   "Im severly underpaid and depressed :D!",
		   "Guess saying it to a random guy won't just fix it.",
		   "*sigh* guess I will go back to cleaning..."]

func _on_TheDepressedJanitor_body_entered(body):
	if body.name == 'Player':
		STATE = true

func _on_TheDepressedJanitor_body_exited(body):
	if body.name == 'Player':
		STATE = false
		$Dialogue_Box.visible = false

func _input(event): 
	if STATE and event.is_action_pressed("ui_accept"):
		$Dialogue_Box.visible = true
	if STATE and event.is_action_pressed("exit_dialogue"):
		
		queue_text = queue_text + 1
		GlobalScript.queue_text($Dialogue_Box, dialogue_text, queue_text, 0.05, 4)
	if STATE == false:
		queue_text = -1
		$Dialogue_Box/Text.text = dialogue_text[0]
