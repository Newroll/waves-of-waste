extends Area2D

var trash
var rotation_var
var rotate_dir
var id = 0
var picked_up = false

func _ready():
	await get_tree().create_timer(0.1).timeout # adds a small timeout before the next line runs so that the id can be properly set by the scene that instantiates this node
	id = int($ID.get_text())
	trash = int(randf_range(0, Main.trash_list.size())) # randomizes the trash
	
	# automagically sets everything (with string concatenation)
	$TrashSprite.texture = load("res://assets/trash/" + Main.trash_list[trash].path)
	$CanvasLayer/TextureRect.texture = load("res://assets/trash/" + Main.trash_list[trash].path)
	$CanvasLayer/Description.text = Main.trash_list[trash].description
	
	rotation_var = randf_range(-3.14, 3.14) # p.s. godot works in radians, -3.14 to 3.14 is the same as 0 to 360 degrees
	$TrashSprite.rotate(rotation_var) # randomizes the rotation of the trash
	trash_animation()

func trash_animation():
	rotate_dir = randf_range(-1, 1)
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
	# function calls itself to play the animation again
	trash_animation()

func _on_body_entered(body):
	if body.name == "Player" and picked_up == false: # checks if it's really the player picking up the trash; we don't want trash picking each other up
		self.visible = false
		picked_up = true
		$SFX.play()
		Main.points += 1
		Main.trash_visible[id] = 1 # we'll pretend that the trash is "visible" on screen after it is picked up even though it is not
		# if the player has not seen the trash before, show the trash menu, otherwise just kills the trash
		if Main.trash_seen[trash] == 0:
			Main.trash_seen[trash] = 1
			$CanvasLayer.show()
			if Main.auto_tts == true:
				DisplayServer.tts_speak(Main.trash_list[trash].description, Main.voice_id, Main.tts_volume)
			Main.pause_block = true
			get_tree().paused = true # pauses the game and show the ui
			timer_tick()
		else:
			await get_tree().create_timer(0.75).timeout
			queue_free()

func timer_tick():
	var n = 5
	if Main.auto_tts == true:
		n = 12
		$CanvasLayer/TimeLabel.set_text("12")
	# for loop instead of manually setting everything
	for i in n:
		await get_tree().create_timer(1.0).timeout
		$CanvasLayer/TimeLabel.set_text(str(n - 1 - i))
	$CanvasLayer.hide()
	Main.pause_block = false
	get_tree().paused = false 
	queue_free()

# checks if the trash is visible on screen or not
func _on_visible_on_screen_notifier_2d_screen_entered():
	Main.trash_visible[id] = 1

func _on_visible_on_screen_notifier_2d_screen_exited():
	if picked_up == false:
		Main.trash_visible[id] = 0
