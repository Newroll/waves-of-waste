extends CharacterBody2D

const BASESPEED = 50 # defines base speed of the player
const MAXSPEED = 100 # defines the max speed of the player
const ACCELERATION = 1 # defines acceleration per frame
const DECELERATION = 3 # same as above but deceleration

var speed = 0 # the current speed of the player

var current_direction = "down" # for animation purposes

func _physics_process(_delta):
	movement()
	sprite_animation()

func movement():
	# gets inputs
	var direction_vertical = Input.get_axis("move_up", "move_down")
	var direction_horizontal = Input.get_axis("move_left", "move_right")

	# horizontal movement
	if direction_horizontal&&!direction_vertical: # if player is moving horizontally and not vertically. prevents diagonal movement
		if speed < MAXSPEED:
			speed += ACCELERATION
		velocity.x = direction_horizontal * speed
		velocity.y = 0
	else:
		# deceleration shenanigans
		if velocity.x > 0:
			velocity.x -= DECELERATION
		if velocity.x < 0:
			velocity.x += DECELERATION
		# make sure velocity returns to 0 if it's close enough
		if velocity.x < 6&&velocity.x > - 6&&velocity.x != 0:
			velocity.x = 0
			speed = 0
	
	# vertical movement
	if direction_vertical&&!direction_horizontal: # if player is moving horizontally and not vertically. prevents diagonal movement
		if speed < MAXSPEED:
			speed += ACCELERATION
		velocity.y = direction_vertical * speed
		velocity.x = 0
	else:
		# deceleration shenanigans
		if velocity.y > 0:
			velocity.y -= DECELERATION
		if velocity.y < 0:
			velocity.y += DECELERATION
		# make sure velocity returns to 0 if it's close enough
		if velocity.y < 6&&velocity.y > - 6&&velocity.y != 0:
			velocity.y = 0
			speed = 0

func sprite_animation():
	# sets animation of player sprite depending on velocity
	if velocity.x < 0:
		$Move.set_animation("left")
		current_direction = "left"
	if velocity.x > 0:
		$Move.set_animation("right")
		current_direction = "right"
	if velocity.y < 0:
		$Move.set_animation("up")
		current_direction = "up"
	if velocity.y > 0:
		$Move.set_animation("down")
		current_direction = "down"
	if velocity.y == 0&&velocity.x == 0:
		$Move.hide()
		$Idle.show()
		$Idle.set_animation(current_direction)
	else:
		$Move.show()
		$Idle.hide()

	move_and_slide()
