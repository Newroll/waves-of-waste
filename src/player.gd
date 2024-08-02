extends CharacterBody2D

const BASESPEED = 50 # defines base speed of the player
const MAXSPEED = 100 # defines the max speed of the player
const ACCELERATION = 1 # defines acceleration per frame
const DECELERATION = 3 # same as above but deceleration

var speed = Vector2(0 ,0) # the current speed of the player

var adjacent
var hypotenuse
var theta

func _physics_process(_delta):
	var direction_vertical = Input.get_axis("move_up", "move_down")
	var direction_horizontal = Input.get_axis("move_left", "move_right")
	
	# horizontal movement
	if direction_horizontal: 
		if speed.x < MAXSPEED:
			speed.x += ACCELERATION
		velocity.x = direction_horizontal * speed.x
	
	# vertical movement
	if direction_vertical: 
		if speed.y < MAXSPEED:
			speed.y += ACCELERATION
		velocity.y = direction_vertical * speed.y
	
	# deceleration
	if not direction_vertical and not direction_horizontal:
		deceleration()
	
	print(velocity)
	sprite_rotation()
	move_and_slide()

func deceleration():
		if velocity.y > 0:
			velocity.y -= DECELERATION
		if velocity.y < 0:
			velocity.y += DECELERATION
		if velocity.x > 0:
			velocity.x -= DECELERATION
		if velocity.x < 0:
			velocity.x += DECELERATION
		# make sure velocity returns to 0 if it's close enough
		if velocity.y < 6 and velocity.y > - 6 and velocity.y != 0:
			velocity.y = 0w
			speed.y = 0
		if velocity.x < 6 and velocity.x > - 6 and velocity.x != 0:
			velocity.x = 0
			speed.x = 0

func sprite_rotation():
	# level 2 physics moment
	theta = atan(abs(velocity.x)/abs(velocity.y))
	if !is_nan(theta):
		if velocity.x > 0:
			if velocity.y > 0:
				$Sprite2D.rotation = theta
			if velocity.y < 0:
				$Sprite2D.rotation = theta - PI/2
		if velocity.x < 0:
			if velocity.y > 0:
				$Sprite2D.rotation = theta + PI/2
			if velocity.y < 0:
				$Sprite2D.rotation = theta - PI
		if velocity.x == 0:
			if velocity.y > 0:
				$Sprite2D.rotation = PI/2
			if velocity.y < 0:
				$Sprite2D.rotation = -PI/2
		if velocity.y == 0:
			if velocity.x > 0:
				$Sprite2D.rotation = 0
			if velocity.x < 0:
				$Sprite2D.rotation = PI
