extends CanvasLayer

var trashScene = preload("res://src/trash_menu.tscn")
var settingsScene = preload("res://src/settings.tscn")
var helpScene = preload("res://src/help-menu.tscn")
var paused = false

func _process(_delta):
	# sets text, bit of string concactnation
	$textLabel.text = str(Main.points) + "/" + str(Main.maxPoints[Main.currentLevel-1]) + " | " + str(Main.formattedTime)
	# checks fullscreen status and sets texture
	if DisplayServer.window_get_mode() == 3:
		$hudopacity/fullscreen.icon = load("res://assets/ui/exit_fullscreen.png")
	else:
		$hudopacity/fullscreen.icon = load("res://assets/ui/enter_fullscreen.png")

func _input(event):
	if event.is_action_pressed("fullscreen"):
		_on_fullscreen_pressed()
	if event.is_action_pressed("escape"):
		if paused == true:
			_on_unpause_pressed()
		else:
			_on_pause_pressed()

func _on_pause_pressed():
	paused = true
	$forwardsfx.play()
	get_tree().paused = true
	$pause.hide()
	$hudopacity.show()

# literally the same as the menu

func _on_fullscreen_pressed():
	# checks fullscreen status and enters/exits fullscreen mode
	if DisplayServer.window_get_mode() == 3:
		$backsfx.play()
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		$forwardsfx.play()
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_settings_pressed():
	$forwardsfx.play()
	get_tree().paused = true
	$hudopacity.show()
	# puts it on top of the hud instead of changing the scene
	add_child(settingsScene.instantiate())

func _on_unpause_pressed():
	paused = false
	get_tree().paused = false
	$backsfx.play()
	$pause.show()
	$hudopacity.hide()

func _on_backmenu_pressed():
	get_tree().paused = false
	$backsfx.play()
	$pause.show()
	$hudopacity.hide()
	Main.change_scene("res://src/main-menu.tscn")

func _on_helpmenu_pressed():
	$forwardsfx.play()
	get_tree().paused = true
	$hudopacity.show()
	# puts it on top of the hud instead of changing the scene
	add_child(helpScene.instantiate())

func _on_trash_button_pressed():
	$forwardsfx.play()
	get_tree().paused = true
	$hudopacity.show()
	# puts it on top of the hud instead of changing the scene
	add_child(trashScene.instantiate())
