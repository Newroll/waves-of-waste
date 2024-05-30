extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# sets the time
	Main.eclapsedTime = $timer.get_time_left()

func _on_timer_timeout():
	get_tree().paused = true
	# scorekeeping stuff
	Main.rating[Main.currentLevel-1] = float(Main.points)/float(Main.maxPoints[Main.currentLevel-1])
	Main.points = 0
	# make sure this is saved
	Main.currentLevel += 1
	Main.writeSave()
	# yes rico, kaboom
	Main.change_scene("res://src/end-scene.tscn")
