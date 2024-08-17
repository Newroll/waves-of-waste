extends CanvasLayer

# preloads the scenes to be loaded on top of this scene
var trash_scene = preload("res://src/trash_menu.tscn")
var settings_scene = preload("res://src/settings.tscn")
var help_scene = preload("res://src/help_menu.tscn")

var paused = false
var current_level

# trig stuff for the pointers
var hyp = 95
var adj
var opp

func _ready():
	current_level = Main.current_level

	# prepares pointers based on the amount of trash there could be on the current level by duplicating a template node
	for i in Main.max_points[Main.current_level - 1]:
		$TrashPointers.add_child($PointerTemplate.duplicate())
	$PointerTemplate.queue_free() # removes the template because we don't need it anymore

func _process(_delta):
	# sets text on the top bar, bit of string concactnation
	$TextLabel.text = str(Main.points) + "/" + str(Main.max_points[Main.current_level - 1]) + " | " + str(Main.formatted_time)

	# checks fullscreen status and sets texture
	if DisplayServer.window_get_mode() == 3:
		$PauseMenu/Fullscreen.icon = load("res://assets/ui/exit_fullscreen.png")
	else:
		$PauseMenu/Fullscreen.icon = load("res://assets/ui/enter_fullscreen.png")
	
	# code to make the pointers work 
	for i in Main.max_points[current_level - 1]: # repeats the following code for each and every pointer
		adj = cos(Main.camera_position.angle_to_point(Main.trash_positions[i])) * hyp * 2.0526 # trigonometry to calculate the x-shift of the pointer, the 2.0526 is to make the circle fatter
		opp = sin(Main.camera_position.angle_to_point(Main.trash_positions[i])) * hyp # same as above but for the y-shift
		$TrashPointers.get_child(i).rotation = Main.camera_position.angle_to_point(Main.trash_positions[i]) # rotates the pointer to actually point towards the trash
		$TrashPointers.get_child(i).position = Vector2(199 + adj, 120 + opp) # sets the appropriate position calcualted earlier
		if Main.trash_visible[i] == 0: # only shows the pointer if the trash is not visible but still exists, this is value is determined in trash.gd
			$TrashPointers.get_child(i).show()
		else:
			$TrashPointers.get_child(i).hide()

func _input(event): # hotkey shortcut stuff
	if event.is_action_pressed("fullscreen"):
		_on_fullscreen_pressed()
	if event.is_action_pressed("escape"):
		if paused == true:
			_on_unpause_pressed()
		else:
			_on_pause_pressed()

func _on_pause_pressed():
	if Main.pause_block == false:
		paused = true
		$ForwardSFX.play()
		get_tree().paused = true
		$Pause.hide()
		$PauseMenu.show()

# same as the menu scene
func _on_fullscreen_pressed():
	# checks fullscreen status and enters/exits fullscreen mode
	if DisplayServer.window_get_mode() == 3:
		$BackSFX.play()
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		$ForwardSFX.play()
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_settings_pressed():
	print("hi")
	$ForwardSFX.play()
	Main.pause_block = true
	get_tree().paused = true
	# puts it on top of the hud instead of changing the scene
	add_child(settings_scene.instantiate())

func _on_unpause_pressed():
	if Main.pause_block == false:
		paused = false
		get_tree().paused = false
		$BackSFX.play()
		$Pause.show()
		$PauseMenu.hide()

func _on_backmenu_pressed():
	Main.pause_block = false
	get_tree().paused = false
	$BackSFX.play()
	$Pause.show()
	$PauseMenu.hide()
	Main.change_scene("res://src/main_menu.tscn")

func _on_helpmenu_pressed():
	$ForwardSFX.play()
	Main.pause_block = true
	get_tree().paused = true
	# puts it on top of the hud instead of changing the scene
	add_child(help_scene.instantiate())

func _on_trash_button_pressed():
	$ForwardSFX.play()
	Main.pause_block = true
	get_tree().paused = true
	$PauseMenu.show()
	# puts it on top of the hud instead of changing the scene
	add_child(trash_scene.instantiate())

func _on_hint_button_pressed():
	$HBoxContainer.hide()
	$ForwardSFX.play()
	Main.hint_clicked = true
	$HBoxContainer.hide()
	$TrashPointers.show()
