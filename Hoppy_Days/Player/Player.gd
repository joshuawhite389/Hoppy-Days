extends KinematicBody2D


var motion = Vector2(0,0)
var can_still_jump = true
var jump_was_pressed = false 

const SPEED = 1000
const GRAVITY = 150
const UP = Vector2(0,-1)
const JUMP_SPEED = 3200
const WORLD_LIMIT = 4000
const BOOST_MULTIPLIER = 1.5


signal animate



func _physics_process(_delta):
	apply_gravity()
	jump()
	move()
	animate()
	# warning-ignore:return_value_discarded
	move_and_slide(motion, UP)
	
	


func apply_gravity():
	if position.y > WORLD_LIMIT:
		get_tree().call_group("Gamestate", "end_game")
	elif is_on_floor() and motion.y > 0:
		can_still_jump = true
		motion.y = 0
		if jump_was_pressed == true:
			motion.y -= JUMP_SPEED
			$JumpSFX.stream = load("res://SFX/jump1.ogg")
			$JumpSFX.play()
	elif is_on_ceiling():
		motion.y = 1
	else:
		coyote_time()
		motion.y += GRAVITY
		
		

func jump():
	if Input.is_action_just_pressed("jump"):
		jump_was_pressed = true
		remember_jump_time()
		if can_still_jump == true:
			$JumpSFX.stream = load("res://SFX/jump1.ogg")
			$JumpSFX.play()
			motion.y -= JUMP_SPEED
			
		

func move():
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion.x = -SPEED
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = SPEED
	else:
		motion.x = 0
		
func animate():
	emit_signal("animate", motion)
	
	
func coyote_time():
	yield(get_tree().create_timer(0.3), "timeout")
	can_still_jump = false
	
	
	
func remember_jump_time():
	yield(get_tree().create_timer(0.1), "timeout")
	jump_was_pressed = false
	

	

func hurt():
	position.y -= 1
	yield(get_tree(),"idle_frame")
	motion.y -= JUMP_SPEED
	$HurtSFX.stream = load("res://SFX/pain.ogg")
	$HurtSFX.play()


func boost():
	position.y -= 1
	yield(get_tree(),"idle_frame")
	motion.y -= JUMP_SPEED * BOOST_MULTIPLIER
