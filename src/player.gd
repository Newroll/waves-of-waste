extends CharacterBody2D

const MAX_VELOCITY = 100 # defines the max velocity of the player
const ACCELERATION = 2 # defines acceleration per frame
const DECELERATION = 2 # same as above but deceleration

func _physics_process(_delta):
	var direction_vertical = Input.get_axis("move_up", "move_down")
	var direction_horizontal = Input.get_axis("move_left", "move_right")

	# horizontal movement
	if direction_horizontal: 
		if velocity.x < direction_horizontal * MAX_VELOCITY:
			velocity.x += ACCELERATION
		if velocity.x > direction_horizontal * MAX_VELOCITY:
			velocity.x -= ACCELERATION
	else:
		if velocity.x > 0:
			velocity.x -= DECELERATION
		if velocity.x < 0:
			velocity.x += DECELERATION
		if velocity.x < 6 and velocity.x > - 6 and velocity.x != 0:
			velocity.x = 0
	
	# vertical movement
	if direction_vertical: 
		if velocity.y < direction_vertical * MAX_VELOCITY:
			velocity.y += ACCELERATION
		if velocity.y > direction_vertical * MAX_VELOCITY:
			velocity.y -= ACCELERATION
	else:
		if velocity.y > 0:
			velocity.y -= DECELERATION
		if velocity.y < 0:
			velocity.y += DECELERATION
		if velocity.y < 6 and velocity.y > - 6 and velocity.y != 0:
			velocity.y = 0
	
	$Sprite2D.rotation = velocity.angle()
	$CollisionShape2D.rotation = velocity.angle()
	move_and_slide()
