extends CharacterBody2D

const MAX_VELOCITY = 100
const ACCELERATION = 2
const DECELERATION = 2

func _physics_process(_delta):
	Main.camera_position = $Camera2D.get_screen_center_position()
	var direction_vertical = Input.get_axis("move_up", "move_down")
	var direction_horizontal = Input.get_axis("move_left", "move_right")

	# horizontal movement
	# if there is input, gradually increase speed the player up to a max speed (aka acceleration)
	if direction_horizontal: 
		if velocity.x < direction_horizontal * MAX_VELOCITY:
			velocity.x += ACCELERATION
		if velocity.x > direction_horizontal * MAX_VELOCITY:
			velocity.x -= ACCELERATION
	# if there is no input, gradually slow the player down (aka deceleration)
	else:
		if velocity.x > 0:
			velocity.x -= DECELERATION
		if velocity.x < 0:
			velocity.x += DECELERATION
		# if there is no input, changes the velocity to 0 if it isd close enough to it
		if velocity.x < 6 and velocity.x > - 6 and velocity.x != 0:
			velocity.x = 0
	
	# vertical movement, same as horiontal movement but for the y axis
	# if there is input, gradually increase speed the player up to a max speed (aka acceleration)
	if direction_vertical: 
		if velocity.y < direction_vertical * MAX_VELOCITY:
			velocity.y += ACCELERATION
		if velocity.y > direction_vertical * MAX_VELOCITY:
			velocity.y -= ACCELERATION
	# if there is no input, gradually slow the player down (aka deceleration)
	else:
		if velocity.y > 0:
			velocity.y -= DECELERATION
		if velocity.y < 0:
			velocity.y += DECELERATION
		# if there is no input, changes the velocity to 0 if it isd close enough to it
		if velocity.y < 6 and velocity.y > - 6 and velocity.y != 0:
			velocity.y = 0
	
	# rotates the sprite based on the direction the player is facing
	$Sprite2D.rotation = velocity.angle()
	$CollisionShape2D.rotation = velocity.angle()
	move_and_slide()
