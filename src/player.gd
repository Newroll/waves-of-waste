extends CharacterBody2D

var speed = 100 # defines the speed of the player
var currentDirection = "down" # for animation purposes

func _physics_process(delta):
	basic_movement()
	sprite_animation()

func basic_movement():
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
