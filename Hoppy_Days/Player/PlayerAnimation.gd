extends AnimatedSprite



func _on_Player_animate(motion):
	if motion.y != 0 and motion.y != 150:
		play("jump")
		
	elif motion.x < 0:	
		flip_h = true
		play("walk")
	elif motion.x > 0:
		flip_h = false
		play("walk")

	else:
		play("idle")


