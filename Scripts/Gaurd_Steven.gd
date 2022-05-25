extends Area2D
#Some variables
var CHAR_READ_RATE = 0.0005
var queue_text = -2
var STATE = false
# Text
var dialogue_text = ["Hi how are you?", 
		   "Make sure you go back to your jail sell",
		   "Or boss will be mad at me :("]
# A bunch of function!!!		
func _on_body_entered(body):
	if body.name == 'Player':
		STATE = true

func _on_body_exited(body):
	if body.name == 'Player':
		STATE = false
		$Dialogue_Box.visible = false
		
func _input(event): 
	if STATE and event.is_action_pressed("ui_accept"):
		$Dialogue_Box.visible = true
	if STATE and event.is_action_pressed("exit_dialogue"):
		
		queue_text = queue_text + 1
		GlobalScript.queue_text($Dialogue_Box, dialogue_text, queue_text, 0.05, 3)
	if STATE == false:
		queue_text = -1
		$Dialogue_Box/Text.text = dialogue_text[0]
	
