extends CanvasLayer

func _process(_delta):
	# sets text, bit of string concactnation
	$textLabel.text = str(Main.points) + "/" + str(Main.maxPoints[Main.currentLevel-1]) + " | " + str(Main.formattedTime)

func _on_pause_pressed():
	get_tree().paused = true
	$pause.hide()
	$hudopacity.show()

# literally the same as the menu
# this is a boolean value that sets the fullscreen status of the game
func _on_fullscreen_toggled(toggled_on):
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if toggled_on == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

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
	$pause.show()
	$hudopacity.show()
	Main.change_scene("res://src/trash_menu.tscn")
