extends KinematicBody2D

var velocity = Vector2(0, 0)
#variables
export var MOVE_SPEED = 20
export var ACCELERATION = 10
export var JUMP_ACCELERATION = 15
export var MAX_SPEED = 20
export var FRICTION = 500
export var GRAVITY = 20
export var JUMP_FORCE = -1200

#movement script
func _physics_process(_delta):
	if Input.is_action_pressed("right"):
		velocity.x = MOVE_SPEED * ACCELERATION
		velocity.clamped(MAX_SPEED)
	elif Input.is_action_pressed("left"):
		velocity.x = -MOVE_SPEED * ACCELERATION
		velocity.clamped(MAX_SPEED)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
		
		
	velocity.y += GRAVITY * JUMP_ACCELERATION
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE
		
	velocity = move_and_slide(velocity, Vector2.UP)
