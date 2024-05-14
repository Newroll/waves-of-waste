extends CharacterBody2D

const BASESPEED = 50 # defines base speed of the player
const MAXSPEED = 100 # defines the max speed of the player
const ACCELERATION = 1 # defines acceleration per frame
const DECELERATION = 3 # same as above but deceleration

var speed = 0 # the current speed of the player

var currentDirection = "down" # for animation purposes

func _physics_process(_delta):
	movement()
	sprite_animation()

func movement():
	# gets inputs
	var directionVertical = Input.get_axis("move_up", "move_down")
	var directionHorizontal = Input.get_axis("move_left", "move_right")

	# horizontal movement
	if directionHorizontal && !directionVertical: # if player is moving horizontally and not vertically. prevents diagonal movement
		if speed < MAXSPEED:
			speed += ACCELERATION
		velocity.x = directionHorizontal * speed
		velocity.y = 0
	else:
		# deceleration shenanigans
		if velocity.x > 0:
			velocity.x -= DECELERATION
		if velocity.x < 0:
			velocity.x += DECELERATION
		# make sure velocity returns to 0 if it's close enough
		if velocity.x < 6 && velocity.x > -6 && velocity.x != 0:
			velocity.x = 0
			speed = 0
	
	# vertical movement
	if directionVertical && !directionHorizontal: # if player is moving horizontally and not vertically. prevents diagonal movement
		if speed < MAXSPEED:
			speed += ACCELERATION
		velocity.y = directionVertical * speed
		velocity.x = 0
	else:
		# deceleration shenanigans
		if velocity.y > 0:
			velocity.y -= DECELERATION
		if velocity.y < 0:
			velocity.y += DECELERATION
		# make sure velocity returns to 0 if it's close enough
		if velocity.y < 6 && velocity.y > -6 && velocity.y != 0:
			velocity.y = 0
			speed = 0

func sprite_animation():
	# sets animation of player sprite depending on velocity
	if velocity.x < 0:
		$move.set_animation("left")
		currentDirection = "left"
	if velocity.x > 0: 
		$move.set_animation("right")
		currentDirection = "right"
	if velocity.y < 0:
		$move.set_animation("up")
		currentDirection = "up"
	if velocity.y > 0:
		$move.set_animation("down")
		currentDirection = "down"
	if velocity.y == 0 && velocity.x == 0:
		$move.hide()
		$idle.show()
		$idle.set_animation(currentDirection)
	else:
		$move.show()
		$idle.hide()

	move_and_slide()
