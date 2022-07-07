extends KinematicBody2D

onready var timer = $Timer
onready var timer2 = $Timer2
onready var timer3 =  $Timer3
var is_moving_left = false
var velocity = Vector2(0, 0)
var speed = -16

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random_turn_numb = rng.randf_range(3, 10)
	timer.set_wait_time(0.01)
	timer.start()
	timer2.set_wait_time(random_turn_numb)
	timer.start()
	timer3.set_wait_time(2)
	timer3.start()

func _process(delta):
	$AnimationPlayer.play("Buzz")
	detect_turn_around()

func _on_Timer_timeout():
	velocity.x = -speed if is_moving_left else speed
	
	velocity = move_and_slide(velocity, Vector2.UP)
		
func _on_Timer2_timeout():
	is_moving_left = !is_moving_left

func _on_Timer3_timeout():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random_flight_numb = rng.randf_range(-6, 6)
	velocity.y = random_flight_numb

func detect_turn_around():
	if is_on_wall():
		is_moving_left = !is_moving_left
