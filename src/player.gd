extends CharacterBody2D

var speed = 100 # defines the speed of the player

func _physics_process(delta):

	# simple boilerplate code for basic movement w/o acceleration
	var directionHorizontal = Input.get_axis("move_left", "move_right")
	if directionHorizontal:
		velocity.x = directionHorizontal * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	var directionVertical = Input.get_axis("move_up", "move_down")
	if directionVertical:
		velocity.y = directionVertical * speed
		velocity.x = 0 # overrides horizontal movement to disable diagonal movement
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
	
	# sets animation of sprite
	if velocity.x < 0:
		$move.set_animation("left")
	if velocity.x > 0: 
		$move.set_animation("right")
	if velocity.y < 0:
		$move.set_animation("up")
	if velocity.y > 0:
		$move.set_animation("down")

	move_and_slide()
