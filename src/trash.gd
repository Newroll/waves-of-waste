extends Area2D

var trash
var rotationVar
var rotateDir

func _ready():
	trash = int(randf_range(0, Main.trashList.size())) # randomizes the trash sprite
	
	# automagically sets everything
	$trashSprite.texture = load("res://assets/trash/" + Main.trashList[trash].path)
	$CanvasLayer/TextureRect.texture = load("res://assets/trash/" + Main.trashList[trash].path)
	$CanvasLayer/description.text = Main.trashList[trash].description
	
	rotationVar = randf_range(-3.14, 3.14)
	$trashSprite.rotate(rotationVar) # randomizes the rotation of the trash
	trash_animation()

func trash_animation():
	rotateDir = randf_range(-1, 1)
	# why is the rotation property in radians
	if rotateDir >= 0:
		$trashSprite.rotate(0.3)
		await get_tree().create_timer(1.0).timeout
		$trashSprite.rotate(-0.3)
		await get_tree().create_timer(1.0).timeout
	else:
		$trashSprite.rotate(-0.3)
		await get_tree().create_timer(1.0).timeout
		$trashSprite.rotate(0.3)
		await get_tree().create_timer(1.0).timeout
	# look at this the function calls itself to play the animation again
	trash_animation()

func _on_body_entered(body):
	if body.name == "player": # checks if it's really the player picking up the trash; we don't want trash picking each other up
		self.visible = false
		$AudioStreamPlayer.play()
		Main.points += 1
		$CanvasLayer.show()
		get_tree().paused = true # pauses the game and show the ui
		timerTick()

func timerTick():
	# for loop instead of manually setting everything
	for i in 5: # kokomileaderofthewatatsu-
		await get_tree().create_timer(1.0).timeout
		$CanvasLayer/timeLabel.set_text(str(4-i))
	$CanvasLayer.hide()
	get_tree().paused = false # does the reverse of above function
	queue_free() # kills the child
