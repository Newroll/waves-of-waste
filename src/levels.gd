extends Node2D

var trash = preload("res://src/trash.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	$GameMusic.play(120)
	
	# automatic trash spawning
	for i in Main.max_points[Main.current_level - 1]:
		Main.trash_visible.append(0)
		$Trash.add_child(trash.instantiate())
		Main.trash_positions.append(Vector2(randf_range(30, 740), randf_range(50, 740))) # saves position of the trash to a global variable to be used later
		$Trash.get_child(i).position = Main.trash_positions[i]
		$Trash.get_child(i).get_child(0).set_text(str(i))

func _process(_delta):
	# sets the time
	Main.eclapsed_time = $Timer.get_time_left()
	if Main.max_points[Main.current_level - 1] <= Main.points: # express level ending when all trash has been collected
		_on_timer_timeout()
	# shows the button to show hints if the player is eligible
	if Main.eclapsed_time > 30 or Main.points / Main.max_points[Main.current_level - 1] > 0.8:
		if Main.hint_clicked == false:
			$HUD/HBoxContainer.show()
	else:
		$HUD/HBoxContainer.hide()

func _on_timer_timeout():
	get_tree().paused = true
	$HUD/HBoxContainer.hide()
	Main.hint_clicked = false
	# scorekeeaping stuff
	Main.rating[Main.current_level - 1] = float(Main.points) / float(Main.max_points[Main.current_level - 1])
	Main.points = 0
	# make sure this is saved
	Main.current_level += 1
	Main.write_save()
	if Main.current_level > 5:
		Main.current_level = 1
		Main.rating = [0, 0, 0, 0, 0]
	# ends the level properly
	$HUD.hide()
	$EndScene.show()
	$EndScene.level_ended()
