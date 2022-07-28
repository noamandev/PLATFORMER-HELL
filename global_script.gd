extends Node


# achivement vars
var didDoFirstBattle : bool = false
var didCollectCoin : bool = false
# default vars
var coins : int = 0
var max_health = 100
var health = 100
var damage = 5
var goons_killed = 0
var socializationXP = 0
var ENTERED_DOOR : bool

# dialogue functionallity?
func queue_text(dialogue_box: Node, text, queue_text_max, CHAR_READ_RATE: float, reset_point):
	if queue_text_max >= reset_point:
		dialogue_box.visible = false
		queue_text_max = -2
	dialogue_box.get_child(1).text = text[queue_text_max]
	dialogue_box.get_child(4).interpolate_property(dialogue_box.get_child(1), "percent_visible", 0.0, 1.0, dialogue_box.get_child(1).text.length() * CHAR_READ_RATE, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	dialogue_box.get_child(4).start()
	#print(queue_text_max)
