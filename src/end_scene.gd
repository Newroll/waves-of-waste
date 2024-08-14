extends CanvasLayer

# preloads the scenes to be smcked on top of the scene
var trash_scene = preload("res://src/trash_menu.tscn")
var settings_scene = preload("res://src/settings.tscn")

var selected_level

func _process(_delta):
	# checks fullscreen status and sets texture of the button accordingly
	if DisplayServer.window_get_mode() == 3:
		$Fullscreen.icon = load("res://assets/ui/exit_fullscreen.png")
	else:
		$Fullscreen.icon = load("res://assets/ui/enter_fullscreen.png")

func level_ended():
	if Main.current_level <= 5: # level 6 does not exist so it checks the current level (double protection more or less since it's impossible for Main.current_level to be higher than 5)
		call("_on_lvl_" + str(Main.current_level) + "_pressed")
	if Main.rating[Main.current_level - 2] >= 0.5 and Main.rating[Main.current_level - 2] < 1:
		$Star3.set_animation("empty") # sets two stars to full
	elif Main.rating[Main.current_level - 2] >= 0 and Main.rating[Main.current_level - 2] < 0.5:
		$Star2.set_animation("empty") # sets only one star to full
		$Star3.set_animation("empty")
	elif Main.rating[Main.current_level - 2] <= 0.5:
		$star1.set_animation("empty") # no stars full
		$star2.set_animation("empty")
		$star3.set_animation("empty")

func _on_settings_pressed():
	$ForwardSFX.play()
	Main.pause_block = true
	get_tree().paused = true
	# puts it on top of the hud instead of changing the scene
	add_child(settings_scene.instantiate())

func _on_fullscreen_pressed():
	# checks fullscreen status and enters/exits fullscreen mode
	if DisplayServer.window_get_mode() == 3:
		$BackSFX.play()
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		$ForwardSFX.play()
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_continue_pressed():
	$ForwardSFX.play()
	await get_tree().create_timer(0.17).timeout # for the sound effect to finish playing
	Main.current_level = selected_level
	Main.change_scene("res://src/levels.tscn")

func _on_trashmenu_pressed():
	$ForwardSFX.play()
	Main.pause_block = true
	get_tree().paused = true
	# puts it on top of the hud instead of changing the scene
	add_child(trash_scene.instantiate())

func _on_quitmenu_pressed():
	$BackSFX.play()
	await get_tree().create_timer(0.23).timeout
	Main.pause_block = false
	get_tree().paused = false
	hide()
	Main.change_scene("res://src/main_menu.tscn")

func _on_lvl_1_pressed():
	$ForwardSFX.play()
	selected_level = 1
	$Pointer.show()
	$Pointer.set_position(Vector2(129, 74)) # moves the pointer around

# same thing
func _on_lvl_2_pressed():
	$ForwardSFX.play()
	selected_level = 2
	$Pointer.show()
	$Pointer.set_position(Vector2(164, 74))

func _on_lvl_3_pressed():
	$ForwardSFX.play()
	selected_level = 3
	$Pointer.show()
	$Pointer.set_position(Vector2(199, 74))

func _on_lvl_4_pressed():
	$ForwardSFX.play()
	selected_level = 4
	$Pointer.show()
	$Pointer.set_position(Vector2(234, 74))

func _on_lvl_5_pressed():
	$ForwardSFX.play()
	selected_level = 5
	$Pointer.show()
	$Pointer.set_position(Vector2(269, 74))
