extends CharacterBody2D

const BASESPEED = 50 # defines base speed of the player
const MAXSPEED = 100 # defines the max speed of the player
const ACCELERATION = 2 # defines acceleration per frame
const DECELERATION = 2 # same as above but deceleration

var speed = Vector2(0 ,0) # the current speed of the player
var theta

func _physics_process(_delta):
	var direction_vertical = Input.get_axis("move_up", "move_down")
	var direction_horizontal = Input.get_axis("move_left", "move_right")
	
	# horizontal movement
	if direction_horizontal: 
		if speed.x < direction_horizontal * MAXSPEED:
			speed.x += ACCELERATION
		if speed.x > direction_horizontal * MAXSPEED:
			speed.x -= ACCELERATION
		velocity.x = speed.x
	else:
		if velocity.x > 0:
			velocity.x -= DECELERATION
		if velocity.x < 0:
			velocity.x += DECELERATION
		if velocity.x < 6 and velocity.x > - 6 and velocity.x != 0:
			velocity.x = 0
			speed.x = 0
	
	# vertical movement
	if direction_vertical: 
		if speed.y < direction_vertical * MAXSPEED:
			speed.y += ACCELERATION
		if speed.y > direction_vertical * MAXSPEED:
			speed.y -= ACCELERATION
		velocity.y = speed.y
	else:
		if velocity.y > 0:
			velocity.y -= DECELERATION
		if velocity.y < 0:
			velocity.y += DECELERATION
		if velocity.y < 6 and velocity.y > - 6 and velocity.y != 0:
			velocity.y = 0
			speed.y = 0
	
	# deceleration
	#if not direction_vertical and not direction_horizontal:
		#deceleration()
	
	print(velocity)
	#sprite_rotation()
	move_and_slide()
	
func sprite_rotation():
	# level 2 physics moment
	# use inverse tangent to calculate the angle at which the boat is moving towards
	theta = atan(abs(velocity.x)/abs(velocity.y))
	if !is_nan(theta): # theta can be NaN if one of the arguments above is =0
		# theta is locked between 0 and +pi/2 radians
		# so we need to add/substract some radians to get the correct final angle
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
