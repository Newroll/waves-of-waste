extends CanvasLayer

var trashScene = preload("res://src/trash_menu.tscn")

func _process(_delta):
	# sets text, bit of string concactnation
	$textLabel.text = str(Main.points) + "/" + str(Main.maxPoints[Main.currentLevel-1]) + " | " + str(Main.formattedTime)
	# checks fullscreen status and sets texture
	if DisplayServer.window_get_mode() == 3:
		$hudopacity/fullscreen.icon = load("res://assets/ui/exit_fullscreen.png")
	if DisplayServer.window_get_mode() != 3:
		$hudopacity/fullscreen.icon = load("res://assets/ui/enter_fullscreen.png")

func _on_pause_pressed():
	get_tree().paused = true
	$pause.hide()
	$hudopacity.show()

# literally the same as the menu

func _on_fullscreen_pressed():
	# checks fullscreen status and enters/exits fullscreen mode
	if DisplayServer.window_get_mode() == 3:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	elif DisplayServer.window_get_mode() != 3:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_settings_pressed():
	pass # open the settings menu (not implemented atm)

func _on_unpause_pressed():
	get_tree().paused = false
	$pause.show()
	$hudopacity.hide()

func _on_backmenu_pressed():
	get_tree().paused = false
	$pause.show()
	$hudopacity.hide()
	Main.change_scene("res://src/main-menu.tscn")

func _on_helpmenu_pressed():
	pass # open the help menu (not implemented atm)

func _on_trash_button_pressed():
	get_tree().paused = true
	$hudopacity.show()
	add_child(trashScene.instantiate())
