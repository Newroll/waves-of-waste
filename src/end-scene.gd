extends CanvasLayer

var selectedLevel = Main.currentLevel

func _on_settings_pressed():
	pass # open the settings menu (not implemented atm)

func _on_fullscreen_toggled(toggled_on):
	# again same code as before
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if toggled_on == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_continue_pressed():
	Main.change_scene("res://src/levels/level-" + str(selectedLevel) + ".tscn")

func _on_trashmenu_pressed():
	Main.change_scene("res://src/trash_menu.tscn")

func _on_quitmenu_pressed():
	get_tree().paused = false
	hide()
	Main.change_scene("res://src/main-menu.tscn")

func _on_lvl_1_pressed():
	get_tree().paused = false
	selectedLevel = 1
	$levels/pointer.show()
	$levels/pointer.set_position(Vector2(59,74)) # moves the pointer around

# same thing
func _on_lvl_2_pressed():
	get_tree().paused = false
	selectedLevel = 2
	$levels/pointer.show()
	$levels/pointer.set_position(Vector2(94,74))

func _on_lvl_3_pressed():
	get_tree().paused = false
	selectedLevel = 3
	$levels/pointer.show()
	$levels/pointer.set_position(Vector2(129,74))

func _on_lvl_4_pressed():
	get_tree().paused = false
	selectedLevel = 4
	$levels/pointer.show()
	$levels/pointer.set_position(Vector2(164,74))

func _on_lvl_5_pressed():
	get_tree().paused = false
	selectedLevel = 5
	$levels/pointer.show()
	$levels/pointer.set_position(Vector2(199,74))
