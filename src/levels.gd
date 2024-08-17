extends Node2D

# preloads the scenes to be loaded on top of this scene
var trash = preload("res://src/trash.tscn")

func _ready():
	Main.pause_block = false
	get_tree().paused = false
	$GameMusic.play(120) # plays the music starting at a later time so the players think the music is different to the main menu when it's really just the same track
	
	Main.trash_visible = [] # clears this array to prevent errors
	# automatic trash spawning
	for i in Main.max_points[Main.current_level - 1]:
		Main.trash_visible.append(0) # add an element to the array cleared earlier
		$Trash.add_child(trash.instantiate())
		Main.trash_positions.append(Vector2(randf_range(60, 720), randf_range(60, 740))) # saves position of the trash to a global variable to be used later
		$Trash.get_child(i).position = Main.trash_positions[i] # actually sets the position to the randomly generated position above
		$Trash.get_child(i).get_child(0).set_text(str(i)) # puts the id of the trash into a hidden label in the trash node for later use

func _process(_delta):
	Main.eclapsed_time = $Timer.get_time_left()

	if Main.max_points[Main.current_level - 1] <= Main.points: # express level ending when all trash has been collected
		_on_timer_timeout()

	# shows the button to show hints if the player is eligible
	if Main.eclapsed_time < 30 or Main.points / Main.max_points[Main.current_level - 1] > 0.8:
		if Main.hint_clicked == false:
			$HUD/HBoxContainer.show()
	else:
		$HUD/HBoxContainer.hide()

func _on_timer_timeout():
	Main.pause_block = true
	get_tree().paused = true
	$HUD/HBoxContainer.hide()

	# scorekeeaping stuff
	Main.rating[Main.current_level - 1] = float(Main.points) / float(Main.max_points[Main.current_level - 1])
	Main.points = 0

	# updates global variables and saves the game progress
	Main.current_level += 1
	Main.hint_clicked = false
	if Main.current_level > 5:
		Main.current_level = 1
		Main.rating = [0, 0, 0, 0, 0]
	Main.write_save()

	# ends the level properly
	$HUD.hide()
	$EndScene.show()
	$EndScene.level_ended()
