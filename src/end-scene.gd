extends CanvasLayer

var selectedLevel

func _ready():
	get_tree().paused = true
	if Main.currentLevel <= 5:
		call("_on_lvl_" + str(Main.currentLevel) + "_pressed")
	if Main.rating[Main.currentLevel-2] >= 0.5 && Main.rating[Main.currentLevel-2] < 1:
		$star3.set_animation("empty") # sets two stars to full
	if Main.rating[Main.currentLevel-2] >= 0 && Main.rating[Main.currentLevel-2] < 0.5:
		$star2.set_animation("empty") # sets only one star to full
		$star3.set_animation("empty")

func _process(_delta):
	# checks fullscreen status and sets texture
	if DisplayServer.window_get_mode() == 3:
		$fullscreen.icon = load("res://assets/ui/exit_fullscreen.png")
	if DisplayServer.window_get_mode() != 3:
		$fullscreen.icon = load("res://assets/ui/enter_fullscreen.png")

func _on_settings_pressed():
	pass # open the settings menu (not implemented atm)

func _on_fullscreen_pressed():
	# checks fullscreen status and enters/exits fullscreen mode
	if DisplayServer.window_get_mode() == 3:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	elif DisplayServer.window_get_mode() != 3:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_continue_pressed():
	Main.change_scene("res://src/levels/level-" + str(selectedLevel) + ".tscn")
	get_tree().paused = false

func _on_trashmenu_pressed():
	Main.change_scene("res://src/trash_menu.tscn")

func _on_quitmenu_pressed():
	get_tree().paused = false
	hide()
	Main.change_scene("res://src/main-menu.tscn")

func _on_lvl_1_pressed():
	if Main.currentLevel >= 1:
		selectedLevel = 1
		$pointer.show()
		$pointer.set_position(Vector2(129,74)) # moves the pointer around

# same thing
func _on_lvl_2_pressed():
	if Main.currentLevel >= 2:
		selectedLevel = 2
		$pointer.show()
		$pointer.set_position(Vector2(164,74))

func _on_lvl_3_pressed():
	if Main.currentLevel >= 3:
		selectedLevel = 3
		$pointer.show()
		$pointer.set_position(Vector2(199,74))

func _on_lvl_4_pressed():
	if Main.currentLevel >= 4:
		selectedLevel = 4
		$pointer.show()
		$pointer.set_position(Vector2(234,74))

func _on_lvl_5_pressed():
	if Main.currentLevel >= 5:
		selectedLevel = 5
		$pointer.show()
		$pointer.set_position(Vector2(269,74))
