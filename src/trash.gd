extends Area2D

var trash
var rotation_var
var rotate_dir

func _ready():
	trash = int(randf_range(0, Main.trash_list.size())) # randomizes the trash sprite
	
	# automagically sets everything
	$TrashSprite.texture = load("res://assets/trash/" + Main.trash_list[trash].path)
	$CanvasLayer/TextureRect.texture = load("res://assets/trash/" + Main.trash_list[trash].path)
	$CanvasLayer/Description.text = Main.trash_list[trash].description
	
	rotation_var = randf_range(-3.14, 3.14)
	$TrashSprite.rotate(rotation_var) # randomizes the rotation of the trash
	trash_animation()

func trash_animation():
	rotate_dir = randf_range(-1, 1)
	# why is the rotation property in radians
	if rotate_dir >= 0:
		$TrashSprite.rotate(0.3)
		await get_tree().create_timer(1.0).timeout
		$TrashSprite.rotate(-0.3)
		await get_tree().create_timer(1.0).timeout
	else:
		$TrashSprite.rotate(-0.3)
		await get_tree().create_timer(1.0).timeout
		$TrashSprite.rotate(0.3)
		await get_tree().create_timer(1.0).timeout
	# look at this the function calls itself to play the animation again
	trash_animation()

func _on_body_entered(body):
	if body.name == "Player": # checks if it's really the player picking up the trash; we don't want trash picking each other up
		self.visible = false
		$SFX.play()
		Main.points += 1
		$CanvasLayer.show()
		get_tree().paused = true # pauses the game and show the ui
		timer_tick()

func timer_tick():
	# for loop instead of manually setting everything
	for i in 5: # kokomileaderofthewatatsu-
		await get_tree().create_timer(1.0).timeout
		$CanvasLayer/TimeLabel.set_text(str(4-i))
	$CanvasLayer.hide()
	get_tree().paused = false # does the reverse of above function
	queue_free() # kills the child
