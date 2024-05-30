extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$timer.start()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# sets the time
	Main.eclapsedTime = $timer.get_time_left()

func _on_timer_timeout():
	get_tree().paused = true
	# make sure this is saved
	Main.currentLevel += 1
	Main.writeSave()
	# score stuff
	
	# yes rico, kaboom
	Main.change_scene("res://src/end-scene.tscn")
