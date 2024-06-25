extends Node2D

func _process(_delta):
	# checks fullscreen status and sets texture
	if DisplayServer.window_get_mode() == 3:
		$fullscreen.icon = load("res://assets/ui/exit_fullscreen.png")
	else:
		$fullscreen.icon = load("res://assets/ui/enter_fullscreen.png")

func _input(event):
	if event.is_action_pressed("fullscreen"):
		_on_fullscreen_pressed()

func _on_fullscreen_pressed():
	# checks fullscreen status and enters/exits fullscreen mode
	if DisplayServer.window_get_mode() == 3:
		$forwardsfx.play()
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		$backsfx.play()
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_settings_pressed():
	pass # open the settings menu (not implemented atm)

func _on_play_pressed():
	$forwardsfx.play()
	await get_tree().create_timer(0.17).timeout
	Main.change_scene("res://src/levels/level-" + str(Main.currentLevel) + ".tscn")

func _on_trashmenu_pressed():
	$forwardsfx.play()
	await get_tree().create_timer(0.17).timeout
	Main.change_scene("res://src/trash_menu.tscn")

func _on_helpmenu_pressed():
	pass # open the help menu (not implemented atm)
