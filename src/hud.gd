extends CanvasLayer

var trash_scene = preload("res://src/trash_menu.tscn")
var settings_scene = preload("res://src/settings.tscn")
var help_scene = preload("res://src/help_menu.tscn")
var paused = false
var hyp = 95
var adj
var opp

func _ready():
	for i in Main.max_points[Main.current_level - 1]:
		$TrashPointers.add_child($PointerTemplate.duplicate())
	$PointerTemplate.queue_free()

func _process(_delta):
	# sets text, bit of string concactnation
	$TextLabel.text = str(Main.points) + "/" + str(Main.max_points[Main.current_level - 1]) + " | " + str(Main.formatted_time)
	# checks fullscreen status and sets texture
	if DisplayServer.window_get_mode() == 3:
		$HUDOpacity/Fullscreen.icon = load("res://assets/ui/exit_fullscreen.png")
	else:
		$HUDOpacity/Fullscreen.icon = load("res://assets/ui/enter_fullscreen.png")
	
	for i in Main.max_points[Main.current_level - 1]:
		adj = cos(Main.camera_position.angle_to_point(Main.trash_positions[i])) * hyp * 2.0526
		opp = sin(Main.camera_position.angle_to_point(Main.trash_positions[i])) * hyp
		$TrashPointers.get_child(i).rotation = Main.camera_position.angle_to_point(Main.trash_positions[i])
		$TrashPointers.get_child(i).position = Vector2(199 + adj, 120 + opp)
		if Main.trash_visible[i] == 0:
			$TrashPointers.get_child(i).show()
		else:
			$TrashPointers.get_child(i).hide()

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
	$ForwardSFX.play()
	get_tree().paused = true
	$Pause.hide()
	$HUDOpacity.show()

# literally the same as the menu

func _on_fullscreen_pressed():
	# checks fullscreen status and enters/exits fullscreen mode
	if DisplayServer.window_get_mode() == 3:
		$BackSFX.play()
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		$ForwardSFX.play()
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_settings_pressed():
	$ForwardSFX.play()
	get_tree().paused = true
	$HUDOpacity.show()
	# puts it on top of the hud instead of changing the scene
	add_child(settings_scene.instantiate())

func _on_unpause_pressed():
	paused = false
	get_tree().paused = false
	$BackSFX.play()
	$Pause.show()
	$HUDOpacity.hide()

func _on_backmenu_pressed():
	get_tree().paused = false
	$BackSFX.play()
	$Pause.show()
	$HUDOpacity.hide()
	Main.change_scene("res://src/main_menu.tscn")

func _on_helpmenu_pressed():
	$ForwardSFX.play()
	get_tree().paused = true
	$HUDOpacity.show()
	# puts it on top of the hud instead of changing the scene
	add_child(help_scene.instantiate())

func _on_trash_button_pressed():
	$ForwardSFX.play()
	get_tree().paused = true
	$HUDOpacity.show()
	# puts it on top of the hud instead of changing the scene
	add_child(trash_scene.instantiate())

func _on_hint_button_pressed():
	Main.hint_clicked = true
	$HBoxContainer.queue_free()
	$TrashPointers.show()
