extends Node2D

var trash = preload("res://src/trash.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	$GameMusic.play(120)
	
	# automatic trash spawning
	for i in Main.max_points[Main.current_level - 1]:
		$Trash.add_child(trash.instantiate())
		Main.trash_positions.append(Vector2(randf_range(30, 740), randf_range(50, 740)))
		$Trash.get_child(i).position = Main.trash_positions[i]
	print(Main.trash_positions)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# sets the time
	Main.eclapsed_time = $Timer.get_time_left()
	if Main.max_points[Main.current_level - 1] <= Main.points:
		_on_timer_timeout()
	if Main.eclapsed_time > 30 or Main.points / Main.max_points[Main.current_level - 1] > 0.8:
		$HUD/HBoxContainer.show()
	else:
		$HUD/HBoxContainer.hide()

func _on_timer_timeout():
	get_tree().paused = true
	$HUD/HBoxContainer.hide()
	# scorekeeaping stuff
	Main.rating[Main.current_level - 1] = float(Main.points) / float(Main.max_points[Main.current_level - 1])
	Main.points = 0
	# make sure this is saved
	Main.current_level += 1
	Main.write_save()
	if Main.current_level > 5:
		Main.current_level = 1
		Main.rating = [0, 0, 0, 0, 0]
	# yes rico, kaboom
	$HUD.hide()
	$EndScene.show()
	$EndScene.level_ended()
