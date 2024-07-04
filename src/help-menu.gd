extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("escape"):
		_on_back_button_pressed()

func _on_back_button_pressed():
	get_tree().paused = false
	$backsfx.play()
	await get_tree().create_timer(0.23).timeout
	if Main.currentScene.left(-7) == "res://src/levels/level":
		get_tree().paused = true
		queue_free()
	else:
		Main.change_scene(Main.previousScene)
