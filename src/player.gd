extends CharacterBody2D

const BASESPEED = 50 # defines base speed of the player
const MAXSPEED = 100 # defines the max speed of the player
const ACCELERATION = 1 # defines acceleration per frame
const DECELERATION = 3 # same as above but deceleration

var speed = 0 # the current speed of the player

func _physics_process(_delta):
	var direction_vertical = Input.get_axis("move_up", "move_down")
	var direction_horizontal = Input.get_axis("move_left", "move_right")

	# horizontal movement
	if direction_horizontal&&!direction_vertical: # if player is moving horizontally and not vertically. prevents diagonal movement
		if speed < MAXSPEED:
			speed += ACCELERATION
		velocity.x = direction_horizontal * speed
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
	move_and_slide()

func deceleration():
	print("decel")
	# deceleration shenanigans
	if velocity.y > 0:
		velocity.y -= DECELERATION
	if velocity.y < 0:
		velocity.y += DECELERATION
	if velocity.x > 0:
		velocity.x -= DECELERATION
	if velocity.x < 0:
		velocity.x += DECELERATION
	# make sure velocity returns to 0 if it's close enough
	if velocity.y < 6 && velocity.y > -6 && velocity.y != 0 && velocity.x < 6 && velocity.x > -6 && velocity.x != 0:
		velocity = Vector2(0, 0)
		speed = Vector2(0, 0)
