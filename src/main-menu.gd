extends Node2D

# this is a boolean value that sets the fullscreen status of the game
func _on_fullscreen_toggled(toggled_on):
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if toggled_on == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_settings_pressed():
	pass # open the settings menu (not implemented atm)

func _on_play_pressed():
	Main.change_scene("res://src/levels/level-" + str(Main.currentLevel) + ".tscn")

func _on_trashmenu_pressed():
	Main.change_scene("res://src/trash_menu.tscn")

func _on_helpmenu_pressed():
	pass # open the help menu (not implemented atm)
