extends KinematicBody2D

enum STATES {AIR=1, FLOOR, WALL, PUNCH}
var state = STATES.AIR
var velocity = Vector2(0, 0)
var direction = 1
var isAttacking = false
#variables
export var MOVE_SPEED = 120
export var MAX_SPEED = 150
export var FRICTION = 500
export var GRAVITY = 35
export var JUMP_FORCE = -500

#movement script
func _physics_process(_delta):
	match state: 
		STATES.AIR:
			if is_on_floor():
				state = STATES.FLOOR
				continue
			elif is_near_wall():
				state = STATES.WALL
				continue
			$President.play("Jump")	
			if Input.is_action_pressed("right"):
				velocity.x = MOVE_SPEED
				velocity.clamped(MAX_SPEED)
				$President.flip_h = false
			elif Input.is_action_pressed("left"):
				velocity.x = -MOVE_SPEED
				velocity.clamped(MAX_SPEED)
				$President.flip_h = true
			else:
				velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
				velocity.x = lerp(velocity.x, 0, 0.2)
			set_direction()
			move_and_fall(false)
		STATES.FLOOR:
			if not is_on_floor():
				state = STATES.AIR			
			if Input.is_action_pressed("right"):
				velocity.x = +MOVE_SPEED
				velocity.clamped(MAX_SPEED)
				$President.play("Walking")
				$President.flip_h = false
			elif Input.is_action_pressed("left"):
				velocity.x = -MOVE_SPEED
				velocity.clamped(MAX_SPEED)
				$President.play('Walking')
				$President.flip_h = true
			else:
				velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
				$President.play('Idle')
				velocity.x = lerp(velocity.x, 0, 0.2)
			if Input.is_action_just_pressed("jump") and is_on_floor() and isAttacking == false:
				velocity.y = JUMP_FORCE
				state = STATES.AIR
			if Input.is_action_just_pressed("punch") and isAttacking == false:
				state = STATES.PUNCH
			
			$Hitbox/CollisionShape2D.disabled = true
			$Label.percent_visible = 0
			set_direction()
			move_and_fall(false) 
		STATES.WALL:
			if is_on_floor():
				state = STATES.FLOOR
				continue
			elif not is_near_wall():
				state = STATES.AIR
				continue
			$President.play("Idle")
			if Input.is_action_pressed("jump") and ((Input.is_action_pressed("left") and direction == 1) or (Input.is_action_pressed("right") and direction == -1)):
				velocity.x = 600 * direction
				velocity.y = JUMP_FORCE * 0.7
				state = STATES.AIR
				
			move_and_fall(true) 
		STATES.PUNCH:
			$President.play("Punch")
			$Tween.interpolate_property($Label, "visible_characters", 0, 9, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			isAttacking = true
		
func move_and_fall(slow_fall : bool):
	if slow_fall:
		velocity.y = clamp(velocity.y, JUMP_FORCE, 50)
		#$Tween.interpolate_property($Label, "visible_characters", 0, 5, $Label.text.length() * 0.05, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		#$Tween.start()
	velocity.y = velocity.y + GRAVITY
	velocity = move_and_slide(velocity, Vector2.UP)

func set_direction():
	direction = 1 if $President.flip_h else -1
	$WallChecker.rotation_degrees = 269 * -direction
	$Hitbox.rotation_degrees = 8 * direction

func is_near_wall():
	return $WallChecker.is_colliding()


func _on_President_animation_finished():
	if $President.animation == "Punch":
		$Hitbox/CollisionShape2D.disabled = false
		$President.play('Idle')
		isAttacking = false
		state = STATES.FLOOR

func _on_Hitbox_body_entered(body):
	if body.has_method('handle_hit'):
		body.handle_hit()
