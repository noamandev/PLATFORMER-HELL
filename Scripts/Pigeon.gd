extends KinematicBody2D

var is_moving_left = false
var gravity = 10
var velocity = Vector2(0, 0)
var speed = -32

func _ready():
	$AnimationPlayer.play("JumpWalk")
	
func _process(delta): 
	velocity.x = -speed if is_moving_left else speed
	velocity.y = gravity
		
	velocity = move_and_slide(velocity, Vector2.UP)
	detect_turn_around()
	
func detect_turn_around():
	if not $RayCast2D.is_colliding() and is_on_floor():
		is_moving_left = !is_moving_left
		scale.x = -scale.x 
	if is_on_wall():
		is_moving_left = !is_moving_left
		scale.x = -scale.x
