extends CharacterBody2D

const BASESPEED = 50 # defines base speed of the player
const MAXSPEED = 100 # defines the max speed of the player
const ACCELERATION = 1 # defines acceleration per frame
const DECELERATION = 3 # same as above but deceleration

var speed = 0 # defines the current speed of the player

var currentDirection = "down" # for animation purposes

func _physics_process(_delta):
	basic_movement()
	sprite_animation()
	print(speed)

func handle_acceleration():
	if speed < MAXSPEED:
		speed += ACCELERATION

func basic_movement():

	var directionHorizontal = Input.get_axis("move_left", "move_right")
	if directionHorizontal:
		handle_acceleration()
		velocity.x = directionHorizontal * speed
	else:
		if velocity.x > 0:
			velocity.x -= DECELERATION
		if velocity.x < 0:
			velocity.x += DECELERATION
		if velocity.x < 6 && velocity.x > -6 && velocity.x != 0:
			velocity.x = 0
			speed = 0
	
	var directionVertical = Input.get_axis("move_up", "move_down")
	if directionVertical:
		handle_acceleration()
		velocity.y = directionVertical * speed
	else:
		if velocity.y > 0:
			velocity.y -= DECELERATION
		if velocity.y < 0:
			velocity.y += DECELERATION
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
