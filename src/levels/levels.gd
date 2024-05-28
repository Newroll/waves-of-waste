extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# sets the time
	Main.eclapsedTime = $timer.get_time_left()

func _on_timer_timeout():
	get_tree().paused = true
	# yes rico, kaboom
	Main.change_scene("res://src/end-scene.tscn")
