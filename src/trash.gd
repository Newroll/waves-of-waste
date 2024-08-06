extends Area2D

var trash
var rotation_var
var rotate_dir
var id

func _ready():
	await get_tree().create_timer(0.1).timeout # need to wait for the id to be set by the other guy first
	id = int($ID.get_text())
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
		if Main.trash_seen[trash] == 0:
			$CanvasLayer.show()
			if Main.auto_tts == true:
				DisplayServer.tts_speak(Main.trash_list[trash].description, Main.voice_id, Main.tts_volume)
			get_tree().paused = true # pauses the game and show the ui
			timer_tick()
		Main.trash_seen[trash] = 1
		Main.trash_visible[id] = 1 # we'll pretend that the trash is "visible" on screen after it is picked up even though it is not

func timer_tick():
	# for loop instead of manually setting everything
	for i in 5:
		await get_tree().create_timer(1.0).timeout
		$CanvasLayer/TimeLabel.set_text(str(4-i))
	$CanvasLayer.hide()
	get_tree().paused = false # does the reverse of above function
	queue_free() # kills the child

func _on_visible_on_screen_notifier_2d_screen_entered(): # checks if the trash is visible on screen or not
	Main.trash_visible[id] = 1

func _on_visible_on_screen_notifier_2d_screen_exited():
	Main.trash_visible[id] = 0
