extends Node2D

func _process(_delta):
	if DisplayServer.window_get_mode() == 3:
		$fullscreen.icon = load("res://assets/ui/exit_fullscreen.png")
	if DisplayServer.window_get_mode() != 3:
		$fullscreen.icon = load("res://assets/ui/enter_fullscreen.png")

# this is a boolean value that sets the fullscreen status of the game
func _on_fullscreen_pressed():
	if DisplayServer.window_get_mode() == 3:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	elif DisplayServer.window_get_mode() != 3:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_settings_pressed():
	pass # open the settings menu (not implemented atm)

func _on_play_pressed():
	Main.change_scene("res://src/levels/level-" + str(Main.currentLevel) + ".tscn")

func _on_trashmenu_pressed():
	Main.change_scene("res://src/trash_menu.tscn")

func _on_helpmenu_pressed():
	pass # open the help menu (not implemented atm)
