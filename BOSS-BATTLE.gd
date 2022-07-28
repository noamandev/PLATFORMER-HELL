extends Control

#custom signals
signal text_box_closed
signal chose_attack

# Actions left
var isAttacking = false
# voicelines when attacked
var voice_lines = [
	"You punch him with all your might!", # 0
	"You powerfully kick him!", # 1
	"You pull out your secret move! THE UPPERCUT!", # 2
	"The enemy attacks!", #3
	"You're not the only one who has a kick! He ALSO has one!",#4
	"A CRITICAL hit!",#5
	"Oh no! Enemy got a critical hit!",#6
	"What a hit by you!", #7
	"Defended enemy attack sucessfully!", #8
	"You prepare to DEFEND yourself!"#9
]
var voice_line_number : int

# variables
onready var stamina_points = 1
onready var enemy_name = "BigBadBoss"
onready var enemy_health = 200
var enemy_attacks = [
	{
		"name": "[SPC] Fierce Thump Up-Bump!",
		"damage": 20
	},
	{
		"name": "[NRML] WALL BALL!",
		"damage": 10
	},
	{
		"name": "[SPC] FIERCE FIREWALL",
		"damage": 12
	},
	{
		"name": "[NRML] FIERCE PULSE",
		"damage": 10
	}
]
onready var player_health = 100
var player_dmg = 10
var is_defending : bool = false

func _process(_delta):
	# set health for player
	set_health($Background/player_panel/player_data/ProgressBar, GlobalScript.max_health, player_health)
	#set health for enemy
	set_health($enemycontainer/ProgressBar, 200, enemy_health)
	if stamina_points > 100: stamina_points = 100
	elif stamina_points < 0: stamina_points = 0
	else: set_text($Background/player_panel/player_data/stamina_bar, 100, stamina_points)	
	
func _ready():
	$Background/player_panel/player_data/stamina_bar/Timer.set_wait_time(0.10)
	$Background/player_panel/player_data/stamina_bar/Timer.start()
	$Camera2D.position.x = 0
	$Camera2D.position.y = 0
	#default stof
	# Hide Stuff
	$Background/Action_choose_text.hide()
	$Background/Attacks_Container.hide()
	$Background/textbox.hide()
	$Background/action_panel.hide()
	display_text("BigBadBoss: You made A BIG MISTAKE FIGHTING ME!!")
	#show text 
	yield(self, "text_box_closed")
	$Background/action_panel.show()
#setting health function
func set_health(progress_bar, max_health, health):
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = "HP: %d of %d" % [health, max_health]
func set_text(progress_bar, max_stm, stamina):
	progress_bar.value = stamina
	progress_bar.max_value = max_stm
	progress_bar.get_node("Label").text = "STM: %d of %d" % [stamina, max_stm]
func _input(_event):
	#close the text box
	if Input.is_action_just_pressed("ui_accept") and $Background/textbox.visible:
		$Background/textbox.hide()
		emit_signal("text_box_closed")
		$Background/action_panel.show()
		$enemycontainer/ProgressBar.show()
# display the text on the textbox
func display_text(text):
	$Background/action_panel.hide()
	$enemycontainer/ProgressBar.hide()
	$Background/textbox.show()
	$Background/textbox/Label.text = text
#enemy turn
func enemy_turn():
	# check if player is defending
	if is_defending == true:
		is_defending = false
		$AnimationPlayer.play("Mini_Shake")
		yield($AnimationPlayer, "animation_finished")
		if player_health == 100:
			display_text(voice_lines[8])
			yield(self, "text_box_closed")
		else:
			display_text("Defended enemy attack successfully! You healed %d HP!" % [4])
			yield(self, "text_box_closed")
			player_health += 4
	else:
		var random_enemy_attack_num = RandomNumberGenerator.new()
		random_enemy_attack_num.randomize()
		var random_enemy_atk = random_enemy_attack_num.randi_range(0, 3)
		# player lose health 
		player_health = max(0, player_health - enemy_attacks[random_enemy_atk].damage)
		# play animation for you getting damaged
		$AnimationPlayer.play("CameraShake")
		yield($AnimationPlayer, "animation_finished")
		if player_health <= 0:
			get_tree().change_scene("res://DeathScreen.tscn")
		# display how much damage he did
		display_text("Creepy guy used " + enemy_attacks[random_enemy_atk].name + "! HE DID %d DAMAGE TO YOU!" % [enemy_attacks[random_enemy_atk].damage])
		yield(self, "text_box_closed")
# attacking functionality :D!
func _on_Attack_pressed():
	$Background/Attacks_Container.show()
	$Background/Action_choose_text.show()
	$Background/action_panel.hide()
	yield(self, "chose_attack")
	$Background/action_panel.show()
	display_text(voice_lines[voice_line_number])
	yield(self, "text_box_closed")
	var random_crit_chance = RandomNumberGenerator.new()
	random_crit_chance.randomize()
	var crit_rate_chance = random_crit_chance.randi_range(1.0, 4.0)
	print(crit_rate_chance)
	if crit_rate_chance == 3: 
		enemy_health -= player_dmg * 2
		enemy_health = max(0, enemy_health - player_dmg)
		$AnimationPlayer.play("enemy_damaged")
		yield($AnimationPlayer, "animation_finished")
		display_text(voice_lines[5])
		yield(self, "text_box_closed")
		player_dmg = 5
		enemy_turn()
		return 
	enemy_health -= player_dmg / 2
	enemy_health = max(0, enemy_health - player_dmg)
	$AnimationPlayer.play("enemy_damaged")
	yield($AnimationPlayer, "animation_finished")
		
	display_text(voice_lines[7]) #"What a hit by you!"
	yield(self, "text_box_closed")
	
	if enemy_health == 0:
		display_text("%s has fainted" % enemy_name)
		yield(self, "text_box_closed")
		$AnimationPlayer.play("Enemy_died")
		yield($AnimationPlayer, "animation_finished")
		GlobalScript.didDoFirstBattle = true
		yield(get_tree().create_timer(2), "timeout")
		get_tree().change_scene("res://The Outside World.tscn")
	player_dmg = 5
	enemy_turn()
# run away like a coward!
func _on_Run_pressed():
	display_text("You can't go away! NYEH HEHEHEH!!!")
# defend functionallity!
func _on_Defend_pressed():
	is_defending = true
	display_text(voice_lines[9])
	yield(self, "text_box_closed")
	yield(get_tree().create_timer(0.25), "timeout")
	enemy_turn()

# Attaks! ( 3 of them! )
func _on_Punch_pressed():
	if stamina_points < 20: player_dmg = player_dmg - 7
	elif stamina_points < 50: player_dmg = player_dmg - 3
	else: player_dmg = 5
	stamina_points -= 5
	voice_line_number = 0
	$Background/Action_choose_text.hide()
	$Background/Attacks_Container.hide()
	emit_signal("chose_attack")
func _on_Kick_pressed():
	if stamina_points < 20: player_dmg = player_dmg/ 3
	elif stamina_points < 50: player_dmg = player_dmg / 2
	else: player_dmg = 10
	stamina_points -= 10
	voice_line_number = 1
	$Background/Action_choose_text.hide()
	$Background/Attacks_Container.hide()
	emit_signal("chose_attack")
func _on_Uppercut_pressed():
	if stamina_points < 20: player_dmg = player_dmg/ 3
	elif stamina_points < 50: player_dmg = player_dmg / 2
	else: player_dmg = 15
	stamina_points -= 18
	voice_line_number = 2
	$Background/Action_choose_text.hide()
	$Background/Attacks_Container.hide()
	emit_signal("chose_attack")

# increase stamina points
func _on_Timer_timeout():
	stamina_points += 1
